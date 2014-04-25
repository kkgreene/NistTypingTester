using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;
using System.IO;

namespace TypingTester.controls
{
    public partial class Instructions : TypingTester.controls.BaseControl
    {
        public Instructions(BaseForm reciever)
        {
            InitializeComponent();
            addCommand(@"Go To Memorize", new commands.CommandGoToScreen(reciever, Constants.Screen.Memorize));
            addCommand(@"Go To Forced Practice", new commands.CommandGoToScreen(reciever, Constants.Screen.ForcedPractice));
        }

        private void button1_Click(object sender, EventArgs e)
        {
            Session.Instance.AddEvent(new TestEvent(Constants.Event.ControlActivated, Constants.Phase.Instruction, 
                                                    Constants.SubPhase.None, @"Next button pressed"));
            if (Options.Instance.disableFreePractice)
            {
                executeCommand(@"Go To Forced Practice");
            }
            else
            { 
                executeCommand(@"Go To Memorize");
            }
            
        }

        private void Instructions_Load_1(object sender, EventArgs e)
        {
            SetHeaderText("Instructions");
            SetEntityProgressVisibility(false);
            SetRoundProgresssVisibility(false);
            string tempFile = this.SaveTempHtml();
            FileStream source = new FileStream(tempFile, FileMode.Open, FileAccess.Read);
            webBrowser1.DocumentStream = source;
            //webBrowser1.DocumentText = LoadHtml();
            Session.Instance.CurrentPhase = Constants.Phase.Instruction;
            Session.Instance.CurrentSubPhase = Constants.SubPhase.Unknown;
        }

        private string SaveTempHtml()
        {
            string htmlCode = this.LoadHtml();
            string appDataPath = Environment.GetFolderPath(Environment.SpecialFolder.LocalApplicationData);
            string myDocPath = Environment.GetFolderPath(Environment.SpecialFolder.MyDocuments);
            string filepath = Path.Combine(appDataPath, @"NistTypingTester");
            string imgPath = Path.Combine(myDocPath, @"NTTImages");
            Directory.CreateDirectory(filepath);
            // fill in the correct appdata path instead of realtive paths
            htmlCode = htmlCode.Replace(@".\", string.Format(@"{0}\", imgPath));

            string file = Path.Combine(filepath, @"temp.html");
            StreamWriter tempFile = new StreamWriter(file);
            tempFile.WriteLine(htmlCode);
            tempFile.Flush();
            tempFile.Close();
            return file;
        }

        private string LoadHtml()
        {
            Options opt = Options.Instance;
            StringBuilder sb = new StringBuilder();
            string Header = string.Empty;
            string FreePractice = string.Empty;
            string ForcedPractice = string.Empty;
            string Verify = string.Empty;
            string Entry = string.Empty;
            string Footer = string.Empty;

            sb.AppendFormat(@"<html><head></head><body>");
            Header = this.loadFileContents(@".\documents\instructionsHeader.fhtm");
            if (!opt.disableFreePractice) FreePractice = this.loadFileContents(@".\documents\instructionsFreePractice.fhtm");
            if (opt.ForcedPracticeRounds > 0) ForcedPractice = this.loadFileContents(@".\documents\instructionsForcedPractice.fhtm");
            if (opt.VerifyRounds > 0) Verify = this.loadFileContents(@".\documents\instructionsVerify.fhtm");
            Entry = this.loadFileContents(@".\documents\instructionsEntry.fhtm");
            Footer = this.loadFileContents(@".\documents\instructionsFooter.fhtm");

            if (!string.IsNullOrEmpty(Header)) sb.Append(Header);
            if (!string.IsNullOrEmpty(FreePractice)) sb.Append(FreePractice);
            if (!string.IsNullOrEmpty(ForcedPractice)) sb.Append(ForcedPractice);
            if (!string.IsNullOrEmpty(Verify)) sb.Append(Verify);
            if (!string.IsNullOrEmpty(Entry)) sb.Append(Entry);
            if (!string.IsNullOrEmpty(Footer)) sb.Append(Footer);

            sb.AppendFormat(@"</body></html>");

            return sb.ToString();
        }

        private string loadFileContents(string filename)
        {
            string retString = string.Empty;
            if (File.Exists(filename))
            {
                retString = File.ReadAllText(filename);
            }
            return retString;
        }
    }
}
