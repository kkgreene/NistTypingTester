using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using TypingTester.controls;

namespace TypingTester
{
    public partial class BaseForm : Form
    {
        private UserControl currentControl;
        private Constants.Screen _currentScreen = Constants.Screen.Unknown;
        private string participantNumber;

        public Constants.Screen CurrentScreen
        {
            get
            {
                return _currentScreen;
            }

            set
            {
                GoToScreen(value);
            }
        }

        public BaseForm()
        {
            InitializeComponent();
            Bitmap bmp = TypingTester.Properties.Resources.icon;
            this.Icon = Icon.FromHandle(bmp.GetHicon());
        }

        private void exitToolStripMenuItem_Click(object sender, EventArgs e)
        {
            Application.Exit();
        }

        protected void enableOptionsButton(bool state)
        {
            tsbOptions.Enabled = state;
        }

        private void BaseForm_Load(object sender, EventArgs e)
        {
            //ParticipantNumber n = new ParticipantNumber(this);
            //n.Dock = DockStyle.Fill;
            //mainPanel.Controls.Add(n);
            GoToScreen(Constants.Screen.StartScreen);
        }

        private void GoToScreen(Constants.Screen screen)
        {
            UserControl newControl = null;
            switch(screen)
            {
                case Constants.Screen.StartScreen:
                    newControl = new ParticipantNumberControl(this);
                    break;

                case Constants.Screen.ReadyScreen:
                    ParticipantNumberControl c = currentControl as ParticipantNumberControl;
                    participantNumber = c.ParticipantNumber;
                    ReadyScreenControl temp = new ReadyScreenControl(this);
                    temp.ParticipantNumber = participantNumber;
                    newControl = temp;
                    break;

                case Constants.Screen.Proficiency:
                    Session.Instance.start(participantNumber);
                    ProficiencyControl pc = new ProficiencyControl(this);
                    newControl = pc;
                    break;

                case Constants.Screen.Instructions:
                    newControl = new Instructions(this);
                    break;

                case Constants.Screen.Memorize:
                    newControl = new Memorize(this);
                    break;

                case Constants.Screen.ForcedPractice:
                    newControl = new ForcedPractice(this);
                    break;

                case Constants.Screen.Verify:
                    newControl = new Verify(this);
                    break;

                case Constants.Screen.Entry:
                    newControl = new Entry(this);
                    break;

                case Constants.Screen.Recall:
                    newControl = new Recall(this);
                    break;

                case Constants.Screen.ThankYou:
                    newControl = new Thankyou(this);
                    break;

                default:
                    newControl = null;
                    break;
            }
            if (newControl != null)
            {
                BaseControl bc = currentControl as BaseControl;
                if (bc != null) bc.ExitControl();
                newControl.Dock = DockStyle.Fill;
                if (mainPanel.Controls.Count != 0)
                {
                    mainPanel.Controls.Clear();
                }
                mainPanel.Controls.Add(newControl);
                _currentScreen = screen;
                currentControl = newControl;
            }
            else
            {
                MessageBox.Show("Attempt to add null control to main panel.", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

       
    }
}
