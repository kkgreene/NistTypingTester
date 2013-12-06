namespace TypingTester.controls
{
    partial class Memorize
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
            this.lblEntityProgress = new System.Windows.Forms.Label();
            this.lblPassword = new System.Windows.Forms.Label();
            this.tbWorkArea = new TypingTester.CueTextBox();
            this.btnNext = new System.Windows.Forms.Button();
            this.SuspendLayout();
            // 
            // lblEntityProgress
            // 
            this.lblEntityProgress.Anchor = System.Windows.Forms.AnchorStyles.Top;
            this.lblEntityProgress.AutoSize = true;
            this.lblEntityProgress.Location = new System.Drawing.Point(348, 15);
            this.lblEntityProgress.Name = "lblEntityProgress";
            this.lblEntityProgress.Size = new System.Drawing.Size(85, 13);
            this.lblEntityProgress.TabIndex = 0;
            this.lblEntityProgress.Text = "Password # of #";
            // 
            // lblPassword
            // 
            this.lblPassword.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.lblPassword.BackColor = System.Drawing.Color.Moccasin;
            this.lblPassword.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
            this.lblPassword.Font = new System.Drawing.Font("Consolas", 18F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lblPassword.Location = new System.Drawing.Point(23, 57);
            this.lblPassword.Name = "lblPassword";
            this.lblPassword.Size = new System.Drawing.Size(726, 38);
            this.lblPassword.TabIndex = 3;
            this.lblPassword.Text = "Password";
            this.lblPassword.TextAlign = System.Drawing.ContentAlignment.MiddleCenter;
            // 
            // tbWorkArea
            // 
            this.tbWorkArea.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) 
            | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.tbWorkArea.Cue = "Work area ...";
            this.tbWorkArea.Id = null;
            this.tbWorkArea.Location = new System.Drawing.Point(23, 116);
            this.tbWorkArea.Multiline = true;
            this.tbWorkArea.Name = "tbWorkArea";
            this.tbWorkArea.Size = new System.Drawing.Size(726, 272);
            this.tbWorkArea.TabIndex = 0;
            this.tbWorkArea.TargetString = "";
            // 
            // btnNext
            // 
            this.btnNext.Anchor = System.Windows.Forms.AnchorStyles.Bottom;
            this.btnNext.Location = new System.Drawing.Point(353, 394);
            this.btnNext.Name = "btnNext";
            this.btnNext.Size = new System.Drawing.Size(75, 23);
            this.btnNext.TabIndex = 1;
            this.btnNext.Text = "Next";
            this.btnNext.UseVisualStyleBackColor = true;
            this.btnNext.Click += new System.EventHandler(this.btnNext_Click);
            // 
            // Memorize
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.Controls.Add(this.btnNext);
            this.Controls.Add(this.tbWorkArea);
            this.Controls.Add(this.lblPassword);
            this.Controls.Add(this.lblEntityProgress);
            this.Name = "Memorize";
            this.Load += new System.EventHandler(this.Memorize_Load);
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Label lblEntityProgress;
        private System.Windows.Forms.Label lblPassword;
        private CueTextBox tbWorkArea;
        private System.Windows.Forms.Button btnNext;
    }
}
