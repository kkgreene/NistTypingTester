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
            Session.Instance.CurrentSubPhase = Constants.SubPhase.None;
            for (int i = 0; i < Session.Instance.EntityStrings.Length; i++ )
            {
                CueTextBox ctb = new CueTextBox(string.Format("Field{0}", i), "Enter string ...", string.Empty);
                ctb.UseSystemPasswordChar = true;
                ctb.Width = flowLayoutPanel1.Width - 20;
                flowLayoutPanel1.Controls.Add(ctb);
            }
            
        }
    }
}
