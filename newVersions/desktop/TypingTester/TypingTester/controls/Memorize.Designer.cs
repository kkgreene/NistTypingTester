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
            this.pbEntityProgress = new System.Windows.Forms.ProgressBar();
            this.label1 = new System.Windows.Forms.Label();
            this.lblPassword = new System.Windows.Forms.Label();
            this.tbWorkArea = new TypingTester.CueTextBox();
            this.btnNext = new System.Windows.Forms.Button();
            this.SuspendLayout();
            // 
            // lblEntityProgress
            // 
            this.lblEntityProgress.Anchor = System.Windows.Forms.AnchorStyles.Top;
            this.lblEntityProgress.AutoSize = true;
            this.lblEntityProgress.Location = new System.Drawing.Point(358, 11);
            this.lblEntityProgress.Name = "lblEntityProgress";
            this.lblEntityProgress.Size = new System.Drawing.Size(65, 13);
            this.lblEntityProgress.TabIndex = 0;
            this.lblEntityProgress.Text = "Entity # of #";
            // 
            // pbEntityProgress
            // 
            this.pbEntityProgress.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.pbEntityProgress.Location = new System.Drawing.Point(21, 27);
            this.pbEntityProgress.Name = "pbEntityProgress";
            this.pbEntityProgress.Size = new System.Drawing.Size(738, 23);
            this.pbEntityProgress.TabIndex = 1;
            // 
            // label1
            // 
            this.label1.Anchor = System.Windows.Forms.AnchorStyles.Top;
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(165, 62);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(450, 13);
            this.label1.TabIndex = 2;
            this.label1.Text = "Please memorize the string below.  You may use the space provided as a work area " +
    "if needed.";
            // 
            // lblPassword
            // 
            this.lblPassword.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.lblPassword.BackColor = System.Drawing.Color.Moccasin;
            this.lblPassword.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
            this.lblPassword.Font = new System.Drawing.Font("Consolas", 18F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lblPassword.Location = new System.Drawing.Point(21, 92);
            this.lblPassword.Name = "lblPassword";
            this.lblPassword.Size = new System.Drawing.Size(738, 38);
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
            this.tbWorkArea.Location = new System.Drawing.Point(21, 133);
            this.tbWorkArea.Multiline = true;
            this.tbWorkArea.Name = "tbWorkArea";
            this.tbWorkArea.Size = new System.Drawing.Size(738, 272);
            this.tbWorkArea.TabIndex = 4;
            this.tbWorkArea.TargetString = "";
            // 
            // btnNext
            // 
            this.btnNext.Anchor = System.Windows.Forms.AnchorStyles.Bottom;
            this.btnNext.Location = new System.Drawing.Point(353, 411);
            this.btnNext.Name = "btnNext";
            this.btnNext.Size = new System.Drawing.Size(75, 23);
            this.btnNext.TabIndex = 5;
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
            this.Controls.Add(this.label1);
            this.Controls.Add(this.pbEntityProgress);
            this.Controls.Add(this.lblEntityProgress);
            this.Name = "Memorize";
            this.Load += new System.EventHandler(this.Memorize_Load);
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Label lblEntityProgress;
        private System.Windows.Forms.ProgressBar pbEntityProgress;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Label lblPassword;
        private CueTextBox tbWorkArea;
        private System.Windows.Forms.Button btnNext;
    }
}
