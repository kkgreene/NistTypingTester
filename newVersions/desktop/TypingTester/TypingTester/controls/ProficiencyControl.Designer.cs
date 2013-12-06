namespace TypingTester.controls
{
    partial class ProficiencyControl
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
            this.lblProficiencyString = new System.Windows.Forms.Label();
            this.btnNext = new System.Windows.Forms.Button();
            this.tbEntry = new TypingTester.CueTextBox();
            this.lblProgress = new System.Windows.Forms.Label();
            this.SuspendLayout();
            // 
            // lblProficiencyString
            // 
            this.lblProficiencyString.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.lblProficiencyString.BackColor = System.Drawing.Color.Moccasin;
            this.lblProficiencyString.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
            this.lblProficiencyString.Font = new System.Drawing.Font("Consolas", 18F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lblProficiencyString.Location = new System.Drawing.Point(23, 57);
            this.lblProficiencyString.Name = "lblProficiencyString";
            this.lblProficiencyString.Size = new System.Drawing.Size(726, 38);
            this.lblProficiencyString.TabIndex = 3;
            this.lblProficiencyString.Text = "The quick brown fox jumped over the lazy dogs.";
            this.lblProficiencyString.TextAlign = System.Drawing.ContentAlignment.MiddleCenter;
            // 
            // btnNext
            // 
            this.btnNext.Anchor = System.Windows.Forms.AnchorStyles.Top;
            this.btnNext.Enabled = false;
            this.btnNext.Location = new System.Drawing.Point(353, 144);
            this.btnNext.Name = "btnNext";
            this.btnNext.Size = new System.Drawing.Size(75, 23);
            this.btnNext.TabIndex = 2;
            this.btnNext.Text = "Next";
            this.btnNext.UseVisualStyleBackColor = true;
            this.btnNext.Click += new System.EventHandler(this.btnNext_Click);
            // 
            // tbEntry
            // 
            this.tbEntry.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.tbEntry.Cue = "Enter text here ...";
            this.tbEntry.Id = "ProficiencyBox";
            this.tbEntry.Location = new System.Drawing.Point(23, 118);
            this.tbEntry.Name = "tbEntry";
            this.tbEntry.Size = new System.Drawing.Size(726, 20);
            this.tbEntry.TabIndex = 1;
            this.tbEntry.TargetString = "";
            this.tbEntry.TextChanged += new System.EventHandler(this.tbEntry_TextChanged);
            // 
            // lblProgress
            // 
            this.lblProgress.Anchor = System.Windows.Forms.AnchorStyles.Top;
            this.lblProgress.AutoSize = true;
            this.lblProgress.Location = new System.Drawing.Point(359, 15);
            this.lblProgress.Name = "lblProgress";
            this.lblProgress.Size = new System.Drawing.Size(63, 13);
            this.lblProgress.TabIndex = 0;
            this.lblProgress.Text = "Entry # of #";
            // 
            // ProficiencyControl
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.Controls.Add(this.lblProficiencyString);
            this.Controls.Add(this.btnNext);
            this.Controls.Add(this.tbEntry);
            this.Controls.Add(this.lblProgress);
            this.Name = "ProficiencyControl";
            this.Load += new System.EventHandler(this.ProficiencyControl_Load);
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Label lblProgress;
        private System.Windows.Forms.Label lblProficiencyString;
        private CueTextBox tbEntry;
        private System.Windows.Forms.Button btnNext;
    }
}
