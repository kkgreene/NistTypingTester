using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using MouseKeyboardActivityMonitor;
using MouseKeyboardActivityMonitor.WinApi;


namespace TypingTester
{
    public sealed class Session : IDisposable
    {
        #region Properties
        
        private static readonly Session _instance = new Session();
        private bool disposed = false;
        private MouseHookListener _mouseListener;
        private KeyboardHookListener _keyboardListener;

        private StreamWriter rawLog;
        private StreamWriter summaryLog;

        public string ParticipantNumber { get; set; }
        public int CurrentEntity { get; set; }
        public int CurrentProficiencyString { get; set; }
        public int CurrentEntryForEntity { get; set; }
        public int CurrentPracticeRound { get; set; }
        public int CurrentVerifyRound { get; set; }
        public string WorkAreaContents { get; set; }

        private List<string> _proficiencyStrings = new List<string>();
        private List<string> _entityStrings = new List<string>();

        public string[] ProficiencyStrings
        {
            get
            {
                return _proficiencyStrings.ToArray();
            }
        }

        public string[] EntityStrings
        {
            get
            {
                return _entityStrings.ToArray();
            }
        }

        public bool InSession { get; private set; }
        private DateTime _sessionStart;
        private DateTime _phaseStart;
        private DateTime _subPhaseStart;
        private DateTime _entityStart;
        private TimeSpan _timeInFreePractice;
        private TimeSpan _timeInForcedPractice;
        private TimeSpan _timeInVerify;
        private int _timesInFreePractice;
        private int _timesInForcedPractice;
        private int _timesInVerify;
        private Constants.Phase _currentPhase = Constants.Phase.Unknown;
        private Constants.SubPhase _currentSubPhase = Constants.SubPhase.Unknown;

        public Constants.Phase CurrentPhase
        {
            get
            {
                return _currentPhase;
            }

            set 
            {
                DateTime phaseEnd = DateTime.Now;
                if (_currentPhase != value)
                {
                    // if memorize phase is ending output the times in various phases
                    if (_currentPhase == Constants.Phase.Memorize)
                    {
                        WriteToSummaryLog(string.Format("Free Practice {0} times for {1}", _timesInFreePractice, _timeInFreePractice));
                        WriteToSummaryLog(string.Format("Forced Practice {0} times for {1}", _timesInForcedPractice, _timeInForcedPractice));
                        WriteToSummaryLog(string.Format("Verify {0} times for {1}", _timesInVerify, _timeInVerify));
                    }

                    TimeSpan ts = phaseEnd - this._phaseStart;
                    this.AddEvent(new TestEvent(Constants.Event.PhaseEnd, _currentPhase, this.CurrentSubPhase, "Phase End"));
                    WriteToSummaryLog(string.Format("Ending phase {0}, total time in phase {1}", _currentPhase, ts));
                    this.AddEvent(new TestEvent(Constants.Event.PhaseBegin, value, this.CurrentSubPhase, "Phase Start"));
                }
                this._phaseStart = DateTime.Now;
                this._currentPhase = value;
                this._currentSubPhase = Constants.SubPhase.None;
            }
        }

        public Constants.SubPhase CurrentSubPhase
        {
            get
            {
                return _currentSubPhase;
            }
            set
            {
                DateTime subphaseEnd = DateTime.Now;
                if (_currentSubPhase != value)
                {
                    TimeSpan ts = subphaseEnd - _subPhaseStart; 
                    if (_currentSubPhase != Constants.SubPhase.None && _currentSubPhase != Constants.SubPhase.Unknown)
                    { 
                        // log phase sub phase ending
                        WriteToSummaryLog(string.Format("Ending subphase {0}, time in subphase {1}", _currentSubPhase, ts));
                    }
                    // handle reoccuring subphase
                    switch(value)
                    {
                        case Constants.SubPhase.ForcedPractice:
                            _timeInForcedPractice += subphaseEnd - _subPhaseStart;
                            _timesInForcedPractice++;
                            break;

                        case Constants.SubPhase.FreePractice:
                            _timeInFreePractice += subphaseEnd - _subPhaseStart;
                            _timesInFreePractice++;
                            break;

                        case Constants.SubPhase.Verify:
                            _timeInVerify += subphaseEnd - _subPhaseStart;
                            _timesInVerify++;
                            break;
                    }
                    // Log sub phase starting
                    this.AddEvent(new TestEvent(Constants.Event.SubPhaseChange, this.CurrentPhase, value, "Subphase change"));
                    _subPhaseStart = DateTime.Now;
                }
                this._currentSubPhase = value;
            }
        }

        #endregion

        #region constructor, Instance, and IDisposable interface

        private Session()
        {
            // create the keyboard and mouse hooks, for the app only
            Hooker hook = new AppHooker();
            _mouseListener = new MouseHookListener(hook);
            _keyboardListener = new KeyboardHookListener(hook);
            this.InSession = false;
        }

        public static Session Instance
        {
            get
            {
                return _instance;
            }
        }

        public void Dispose()
        {
            Dispose(true);
            GC.SuppressFinalize(this);
        }

        private void Dispose(bool disposing)
        {
            if (!this.disposed)
            {
                if (disposing)
                {
                    closeLogFiles();
                }
                _keyboardListener.Dispose();
                _mouseListener.Dispose();
                this.disposed = true;
                this.InSession = false;
            }
        }

        #endregion

        private void initializeSession(string participant)
        {
            ParticipantNumber = participant;
            initializeLogFiles();
            this.InSession = true;
            this._sessionStart = DateTime.Now;
            this.CurrentEntity = 0;
            this.CurrentEntryForEntity = 1;
            this.CurrentPhase = Constants.Phase.Unknown;
            this.CurrentPracticeRound = 1;
            this.CurrentProficiencyString = 0;
            this.CurrentSubPhase = Constants.SubPhase.Unknown;
            this.WorkAreaContents = string.Empty;
            this._timeInForcedPractice = TimeSpan.Zero;
            this._timeInFreePractice = TimeSpan.Zero;
            this._timeInVerify = TimeSpan.Zero;
            this._timesInForcedPractice = 0;
            this._timesInFreePractice = 0;
            this._timesInVerify = 0;
            this.SetMouseClickLogging(true);
            this.SetKeyDownLogging(true);
        }

        private void loadData()
        {
            InputFile input = new InputFile(@".\documents\inputStrings.xml");
            this._proficiencyStrings = new List<string>(input.ProficiencyStrings);
            this._entityStrings = new List<string>(input.EntityStrings);
        }

        public void start(string particpant)
        {
            loadData();
            initializeSession(particpant);
            //this.EnableHooks();
        }

        public void end()
        {
            closeLogFiles();
            //this.DisableHooks();
            this.InSession = false;
        }

        private void initializeLogFiles()
        {
            string filepath = Environment.GetFolderPath(Environment.SpecialFolder.MyDocuments);
            filepath = Path.Combine(Environment.GetFolderPath(Environment.SpecialFolder.MyDocuments), @"NIST_TypingTesterOutput");
            Directory.CreateDirectory(filepath);
            string rawLogFilename = Path.Combine(filepath, string.Format("{0}-raw.txt", this.ParticipantNumber));
            string summaryLogFilename = Path.Combine(filepath, string.Format("{0}-summary.txt", this.ParticipantNumber));
            rawLog = new StreamWriter(rawLogFilename, false);
            rawLog.AutoFlush = true;
            summaryLog = new StreamWriter(summaryLogFilename, false);
            summaryLog.AutoFlush = true;
            rawLog.WriteLine(TestEvent.LogHeader);
        }

        private void closeLogFiles()
        {
            if (rawLog != null)
            {
                rawLog.Flush();
                rawLog.Close();
                rawLog = null;
            }
            if (summaryLog != null)
            {
                summaryLog.Flush();
                summaryLog.Close();
                summaryLog = null;
            }
        }

        #region Logging methods

        internal void AddEvent(TestEvent te)
        {
            if (this.InSession)
            {
                Log(te.ToString());
            }
        }

        private void Log(string text)
        {
            rawLog.WriteLine(text);
            Console.WriteLine(text);
        }

        private void WriteToSummaryLog(string text)
        {
            summaryLog.WriteLine(text);
        }

        #endregion

        #region methods to turn on and off monitoring of mouse and keyboard events

        public void EnableHooks()
        {
            _mouseListener.Enabled = true;
            _keyboardListener.Enabled = true;
        }

        public void DisableHooks()
        {
            _mouseListener.Enabled = true;
            _keyboardListener.Enabled = true;
        }

        public void SetKeyDownLogging(bool log)
        {
            if (log)
            {
                _keyboardListener.KeyDown += HookManager_KeyDown;
            }
            else
            {
                _keyboardListener.KeyDown -= HookManager_KeyDown;
            }
        }

        public void SetKeyUpLogging(bool log)
        {
            if (log)
            {
                _keyboardListener.KeyUp += HookManager_KeyUp;
            }
            else
            {
                _keyboardListener.KeyUp -= HookManager_KeyUp;
            }
        }

        public void SetKeyPressLogging(bool log)
        {
            if (log)
            {
                _keyboardListener.KeyPress += HookManager_KeyPress;
            }
            else
            {
                _keyboardListener.KeyPress -= HookManager_KeyPress;
            }
        }

        public void SetMouseMoveLogging(bool log)
        {
            if (log)
            {
                _mouseListener.MouseMove += HookManager_MouseMove;
            }
            else
            {
                _mouseListener.MouseMove -= HookManager_MouseMove;
            }
        }
        
        public void SetMouseClickLogging(bool log)
        {
            if (log)
            {
                _mouseListener.MouseClick += HookManager_MouseClick;
            }
            else
            {
                _mouseListener.MouseClick -= HookManager_MouseClick;
            }
        }

        public void SetMouseUpLogging(bool log)
        {
            if (log)
            {
                _mouseListener.MouseUp += HookManager_MouseUp;
            }
            else
            {
                _mouseListener.MouseUp -= HookManager_MouseUp;
            }
        }
        
        public void SetMouseDownLogging(bool log)
        {
            if (log)
            {
                _mouseListener.MouseDown += HookManager_MouseDown;
            }
            else
            {
                _mouseListener.MouseDown -= HookManager_MouseDown;
            }
        }

        public void SetMouseDoubleClickLogging(bool log)
        {
            if (log)
            {
                _mouseListener.MouseDoubleClick += HookManager_MouseDoubleClick;
            }
            else
            {
                _mouseListener.MouseDoubleClick -= HookManager_MouseDoubleClick;
            }
        }
        
        public void SetMouseWheelLogging(bool log)
        {
            if (log)
            {
                _mouseListener.MouseWheel += HookManager_MouseWheel;
            }
            else
            {
                _mouseListener.MouseWheel -= HookManager_MouseWheel;
            }
        }

        #endregion


        #region mouse and keyboard monitoring event handlers

        private void HookManager_KeyDown(object sender, KeyEventArgs e)
        {
            Log(string.Format("KeyDown \t\t {0}\n", e.KeyCode));
        }

        private void HookManager_KeyUp(object sender, KeyEventArgs e)
        {
            Log(string.Format("KeyUp  \t\t {0}\n", e.KeyCode));
        }

        private void HookManager_KeyPress(object sender, KeyPressEventArgs e)
        {
            Log(string.Format("KeyPress \t\t {0}\n", e.KeyChar));
        }

        private void HookManager_MouseMove(object sender, MouseEventArgs e)
        {
            Log(string.Format("x={0:0000}; y={1:0000}", e.X, e.Y));
        }

        private void HookManager_MouseClick(object sender, MouseEventArgs e)
        {
            Log(string.Format("MouseClick \t\t {0}\n", e.Button));
        }

        private void HookManager_MouseUp(object sender, MouseEventArgs e)
        {
            Log(string.Format("MouseUp \t\t {0}\n", e.Button));
        }

        private void HookManager_MouseDown(object sender, MouseEventArgs e)
        {
            Log(string.Format("MouseDown \t\t {0}\n", e.Button));
        }

        private void HookManager_MouseDoubleClick(object sender, MouseEventArgs e)
        {
            Log(string.Format("MouseDoubleClick \t\t {0}\n", e.Button));
        }

        private void HookManager_MouseWheel(object sender, MouseEventArgs e)
        {
            Log(string.Format("Wheel={0:000}", e.Delta));
        }

        #endregion

    }
}
