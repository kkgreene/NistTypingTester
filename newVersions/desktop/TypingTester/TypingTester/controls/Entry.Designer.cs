namespace TypingTester.controls
{
    partial class Entry
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.lblSession = new System.Windows.Forms.Label();
            this.lblEntry = new System.Windows.Forms.Label();
            this.label3 = new System.Windows.Forms.Label();
            this.tbEntry = new TypingTester.CueTextBox();
            this.btnNext = new System.Windows.Forms.Button();
            this.SuspendLayout();
            // 
            // lblSession
            // 
            this.lblSession.AutoSize = true;
            this.lblSession.Location = new System.Drawing.Point(20, 15);
            this.lblSession.Name = "lblSession";
            this.lblSession.Size = new System.Drawing.Size(85, 13);
            this.lblSession.TabIndex = 0;
            this.lblSession.Text = "Password # of #";
            // 
            // lblEntry
            // 
            this.lblEntry.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.lblEntry.AutoSize = true;
            this.lblEntry.Location = new System.Drawing.Point(695, 15);
            this.lblEntry.Name = "lblEntry";
            this.lblEntry.Size = new System.Drawing.Size(71, 13);
            this.lblEntry.TabIndex = 1;
            this.lblEntry.Text = "Round # of #";
            // 
            // label3
            // 
            this.label3.Anchor = System.Windows.Forms.AnchorStyles.Top;
            this.label3.AutoSize = true;
            this.label3.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label3.Location = new System.Drawing.Point(367, 25);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(46, 20);
            this.label3.TabIndex = 2;
            this.label3.Text = "Entry";
            // 
            // tbEntry
            // 
            this.tbEntry.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.tbEntry.Cue = "Enter string here";
            this.tbEntry.Id = null;
            this.tbEntry.Location = new System.Drawing.Point(23, 118);
            this.tbEntry.Name = "tbEntry";
            this.tbEntry.Size = new System.Drawing.Size(726, 20);
            this.tbEntry.TabIndex = 0;
            this.tbEntry.TargetString = "";
            this.tbEntry.UseSystemPasswordChar = true;
            this.tbEntry.TextChanged += new System.EventHandler(this.tbEntry_TextChanged);
            // 
            // btnNext
            // 
            this.btnNext.Anchor = System.Windows.Forms.AnchorStyles.Top;
            this.btnNext.Enabled = false;
            this.btnNext.Location = new System.Drawing.Point(353, 148);
            this.btnNext.Name = "btnNext";
            this.btnNext.Size = new System.Drawing.Size(75, 23);
            this.btnNext.TabIndex = 1;
            this.btnNext.Text = "Next";
            this.btnNext.UseVisualStyleBackColor = true;
            this.btnNext.Click += new System.EventHandler(this.btnNext_Click);
            // 
            // Entry
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.Controls.Add(this.btnNext);
            this.Controls.Add(this.tbEntry);
            this.Controls.Add(this.label3);
            this.Controls.Add(this.lblEntry);
            this.Controls.Add(this.lblSession);
            this.Name = "Entry";
            this.Load += new System.EventHandler(this.Entry_Load);
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Label lblSession;
        private System.Windows.Forms.Label lblEntry;
        private System.Windows.Forms.Label label3;
        private CueTextBox tbEntry;
        private System.Windows.Forms.Button btnNext;
    }
}
