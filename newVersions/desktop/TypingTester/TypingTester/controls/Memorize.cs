using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;

namespace TypingTester.controls
{
    public partial class Memorize : TypingTester.controls.BaseControl
    {
        private string currentString = string.Empty;

        public Memorize(BaseForm reciever)
        {
            InitializeComponent();
            addCommand(@"Go To Practice", new commands.CommandGoToScreen(reciever, Constants.Screen.ForcedPractice));
            addCommand(@"Go To Verify", new commands.CommandGoToScreen(reciever, Constants.Screen.Verify));
            currentString = Session.Instance.EntityStrings[Session.Instance.CurrentEntity];
        }

        private void btnNext_Click(object sender, EventArgs e)
        {
            Session.Instance.AddEvent(new TestEvent(Constants.Event.ControlActivated, Constants.Phase.Memorize, Constants.SubPhase.FreePractice,
                                                    @"Next button pressed"));
            if (Options.Instance.ForcedPracticeRounds == 0)
            {
                executeCommand("Go To Verify");
            }
            else
            {
                executeCommand(@"Go To Practice");
            }
        }

        private void Memorize_Load(object sender, EventArgs e)
        {
            Session.Instance.CurrentPhase = Constants.Phase.Memorize;
            Session.Instance.CurrentSubPhase = Constants.SubPhase.FreePractice;
            lblPassword.Text = currentString;
            lblEntityProgress.Text = string.Format("Entity {0} of {1}", Session.Instance.CurrentEntity + 1, Session.Instance.EntityStrings.Length);
        }

        public override void ExitControl()
        {
            Session.Instance.CurrentSubPhase = Constants.SubPhase.Unknown;
            return;
        }
    }
}
