using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;

namespace TypingTester.controls
{
    public partial class Recall : TypingTester.controls.BaseControl
    {
        public Recall(BaseForm reciever)
        {
            InitializeComponent();
            addCommand(@"Go To Thank You", new commands.CommandGoToScreen(reciever, Constants.Screen.ThankYou));
        }

        private void btnNext_Click(object sender, EventArgs e)
        {
            executeCommand(@"Go To Thank You");
        }

        private void Recall_Load(object sender, EventArgs e)
        {
            Session.Instance.CurrentPhase = Constants.Phase.Recall;
            Session.Instance.CurrentSubPhase = Constants.SubPhase.Unknown;
        }
    }
}
