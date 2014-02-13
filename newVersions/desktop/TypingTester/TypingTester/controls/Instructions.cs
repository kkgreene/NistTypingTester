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
            FileStream source = new FileStream(@".\documents\instructions.html", FileMode.Open, FileAccess.Read);
            webBrowser1.DocumentStream = source;
            Session.Instance.CurrentPhase = Constants.Phase.Instruction;
            Session.Instance.CurrentSubPhase = Constants.SubPhase.Unknown;
        }
    }
}
