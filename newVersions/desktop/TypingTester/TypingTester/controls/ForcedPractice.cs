using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;

namespace TypingTester.controls
{
    public partial class ForcedPractice : TypingTester.controls.BaseControl
    {
        private string currentString;
        public ForcedPractice(BaseForm reciever)
        {
            InitializeComponent();
            addCommand(@"Back To Memorize", new commands.CommandGoToScreen(reciever, Constants.Screen.Memorize));
            addCommand(@"Go To Verify", new commands.CommandGoToScreen(reciever, Constants.Screen.Verify));
            addCommand(@"Go To Recall", new commands.CommandGoToScreen(reciever, Constants.Screen.Recall));
            addCommand(@"Next Entity", new commands.NextEntity(reciever));
            currentString = Session.Instance.EntityStrings[Session.Instance.CurrentEntity];
        }

        private void btnBack_Click(object sender, EventArgs e)
        {
            Session.Instance.AddEvent(new TestEvent(Constants.Event.ControlActivated, Constants.Phase.Memorize, Constants.SubPhase.ForcedPractice,
                                                    @"Back button pressed"));
            executeCommand(@"Back To Memorize");
        }

        private void btnNext_Click(object sender, EventArgs e)
        {
            Session.Instance.AddEvent(new TestEvent(Constants.Event.ControlActivated, Constants.Phase.Memorize, Constants.SubPhase.ForcedPractice,
                                                    @"Next button pressed"));
            // did they get the string correct
            if (tbEntry.Text.Equals(currentString))
            {
                TestEvent te = new TestEvent(Constants.Event.CorrectValueEntered, Constants.Phase.Memorize, Constants.SubPhase.ForcedPractice,
                                              "Correct value entered");
                te.TargetString = currentString;
                Session.Instance.AddEvent(te);
                Session.Instance.CurrentPracticeRound++;
                tbEntry.Text = string.Empty;
            }
            else if (tbEntry.Text.Equals(Options.Instance.QuitString))
            {
                TestEvent te = new TestEvent(Constants.Event.ControlActivated, Constants.Phase.Memorize, Constants.SubPhase.ForcedPractice,
                                             @"Quit string entered");
                te.TargetString = currentString;
                executeCommand(@"Go To Recall");
                return;
            }
            else
            {
                TestEvent te = new TestEvent(Constants.Event.IncorrectValueEntered, Constants.Phase.Memorize, Constants.SubPhase.ForcedPractice,
                                             "Incorrect value entered");
                te.TargetString = currentString;
                Session.Instance.AddEvent(te);
                lblIncorrect.Visible = true;
                imgIncorrect.Visible = true;
            }
            PromptToMoveOn();
            UpdateUi();
        }

        private void PromptToMoveOn()
        {
            if (Session.Instance.CurrentPracticeRound > Options.Instance.ForcedPracticeRounds)
            {
                if (MessageBox.Show("Do you want to proceed to the next phase?", "Move on",
                                    MessageBoxButtons.YesNo, MessageBoxIcon.Question) == DialogResult.Yes)
                {
                    executeCommand(@"Go To Verify");
                }
            }
        }

        private void UpdateUi()
        {
            lblRound.Text = string.Format("Round {0} of {1}", Session.Instance.CurrentPracticeRound, Options.Instance.ForcedPracticeRounds);
            pbRound.Value = Math.Min(Session.Instance.CurrentPracticeRound-1, pbRound.Maximum);
        }

        private void ForcedPractice_Load(object sender, EventArgs e)
        {
            Session.Instance.CurrentPhase = Constants.Phase.Memorize;
            Session.Instance.CurrentSubPhase = Constants.SubPhase.ForcedPractice;
            currentString = Session.Instance.EntityStrings[Session.Instance.CurrentEntity];
            tbEntry.TargetString = currentString;
            lblEntity.Text = currentString;
            lblSessionProgress.Text = string.Format("Entity {0} of {1}", Session.Instance.CurrentEntity+1, Session.Instance.EntityStrings.Length);
            pbSessionProgress.Minimum = 0;
            pbSessionProgress.Maximum = Session.Instance.EntityStrings.Length;
            pbSessionProgress.Value = Session.Instance.CurrentEntity;
            pbRound.Minimum = 0;
            pbRound.Maximum = Options.Instance.ForcedPracticeRounds;
            UpdateUi();
        }

        public override void ExitControl()
        {
            Session.Instance.CurrentSubPhase = Constants.SubPhase.Unknown;
            return;
        }

        private void tbEntry_TextChanged(object sender, EventArgs e)
        {
            lblIncorrect.Visible = false;
            imgIncorrect.Visible = false;
            if (tbEntry.Text.Length > 0)
            {
                btnNext.Enabled = true;
            }
            else
            {
                btnNext.Enabled = false;
            }
        }
    }
}
