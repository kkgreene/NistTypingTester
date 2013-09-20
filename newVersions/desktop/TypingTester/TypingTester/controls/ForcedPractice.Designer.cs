﻿namespace TypingTester.controls
{
    partial class ForcedPractice
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
            this.components = new System.ComponentModel.Container();
            this.lblSessionProgress = new System.Windows.Forms.Label();
            this.lblRound = new System.Windows.Forms.Label();
            this.label3 = new System.Windows.Forms.Label();
            this.tbEntry = new TypingTester.CueTextBox();
            this.lblEntity = new System.Windows.Forms.Label();
            this.pbSessionProgress = new System.Windows.Forms.ProgressBar();
            this.pbRound = new System.Windows.Forms.ProgressBar();
            this.btnNext = new System.Windows.Forms.Button();
            this.imgIncorrect = new System.Windows.Forms.PictureBox();
            this.lblIncorrect = new System.Windows.Forms.Label();
            this.imageList1 = new System.Windows.Forms.ImageList(this.components);
            this.btnBack = new System.Windows.Forms.Button();
            ((System.ComponentModel.ISupportInitialize)(this.imgIncorrect)).BeginInit();
            this.SuspendLayout();
            // 
            // lblSessionProgress
            // 
            this.lblSessionProgress.AutoSize = true;
            this.lblSessionProgress.Location = new System.Drawing.Point(92, 25);
            this.lblSessionProgress.Name = "lblSessionProgress";
            this.lblSessionProgress.Size = new System.Drawing.Size(65, 13);
            this.lblSessionProgress.TabIndex = 0;
            this.lblSessionProgress.Text = "Entity # of #";
            // 
            // lblRound
            // 
            this.lblRound.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.lblRound.AutoSize = true;
            this.lblRound.Location = new System.Drawing.Point(620, 25);
            this.lblRound.Name = "lblRound";
            this.lblRound.Size = new System.Drawing.Size(71, 13);
            this.lblRound.TabIndex = 1;
            this.lblRound.Text = "Round # of #";
            // 
            // label3
            // 
            this.label3.Anchor = System.Windows.Forms.AnchorStyles.Top;
            this.label3.AutoSize = true;
            this.label3.Location = new System.Drawing.Point(256, 91);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(268, 13);
            this.label3.TabIndex = 2;
            this.label3.Text = "Please enter the password string in the space provided.";
            // 
            // tbEntry
            // 
            this.tbEntry.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.tbEntry.Cue = "Enter string here";
            this.tbEntry.Id = null;
            this.tbEntry.Location = new System.Drawing.Point(22, 170);
            this.tbEntry.Name = "tbEntry";
            this.tbEntry.Size = new System.Drawing.Size(737, 20);
            this.tbEntry.TabIndex = 3;
            this.tbEntry.TargetString = "";
            this.tbEntry.TextChanged += new System.EventHandler(this.tbEntry_TextChanged);
            // 
            // lblEntity
            // 
            this.lblEntity.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.lblEntity.BackColor = System.Drawing.Color.Moccasin;
            this.lblEntity.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
            this.lblEntity.Font = new System.Drawing.Font("Consolas", 18F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lblEntity.Location = new System.Drawing.Point(21, 117);
            this.lblEntity.Name = "lblEntity";
            this.lblEntity.Size = new System.Drawing.Size(738, 38);
            this.lblEntity.TabIndex = 4;
            this.lblEntity.Text = "Password1234";
            this.lblEntity.TextAlign = System.Drawing.ContentAlignment.MiddleCenter;
            // 
            // pbSessionProgress
            // 
            this.pbSessionProgress.Location = new System.Drawing.Point(22, 41);
            this.pbSessionProgress.Name = "pbSessionProgress";
            this.pbSessionProgress.Size = new System.Drawing.Size(205, 23);
            this.pbSessionProgress.TabIndex = 5;
            // 
            // pbRound
            // 
            this.pbRound.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.pbRound.Location = new System.Drawing.Point(549, 41);
            this.pbRound.Name = "pbRound";
            this.pbRound.Size = new System.Drawing.Size(205, 23);
            this.pbRound.TabIndex = 6;
            // 
            // btnNext
            // 
            this.btnNext.Anchor = System.Windows.Forms.AnchorStyles.Top;
            this.btnNext.Enabled = false;
            this.btnNext.Location = new System.Drawing.Point(395, 196);
            this.btnNext.Name = "btnNext";
            this.btnNext.Size = new System.Drawing.Size(75, 23);
            this.btnNext.TabIndex = 7;
            this.btnNext.Text = "Next";
            this.btnNext.UseVisualStyleBackColor = true;
            this.btnNext.Click += new System.EventHandler(this.btnNext_Click);
            // 
            // imgIncorrect
            // 
            this.imgIncorrect.Anchor = System.Windows.Forms.AnchorStyles.Top;
            this.imgIncorrect.Location = new System.Drawing.Point(320, 231);
            this.imgIncorrect.Name = "imgIncorrect";
            this.imgIncorrect.Size = new System.Drawing.Size(54, 53);
            this.imgIncorrect.TabIndex = 8;
            this.imgIncorrect.TabStop = false;
            this.imgIncorrect.Visible = false;
            // 
            // lblIncorrect
            // 
            this.lblIncorrect.Anchor = System.Windows.Forms.AnchorStyles.Top;
            this.lblIncorrect.AutoSize = true;
            this.lblIncorrect.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lblIncorrect.ForeColor = System.Drawing.Color.Red;
            this.lblIncorrect.Location = new System.Drawing.Point(380, 246);
            this.lblIncorrect.Name = "lblIncorrect";
            this.lblIncorrect.Size = new System.Drawing.Size(81, 20);
            this.lblIncorrect.TabIndex = 9;
            this.lblIncorrect.Text = "Incorrect";
            this.lblIncorrect.Visible = false;
            // 
            // imageList1
            // 
            this.imageList1.ColorDepth = System.Windows.Forms.ColorDepth.Depth8Bit;
            this.imageList1.ImageSize = new System.Drawing.Size(16, 16);
            this.imageList1.TransparentColor = System.Drawing.Color.Transparent;
            // 
            // btnBack
            // 
            this.btnBack.Anchor = System.Windows.Forms.AnchorStyles.Top;
            this.btnBack.Location = new System.Drawing.Point(310, 196);
            this.btnBack.Name = "btnBack";
            this.btnBack.Size = new System.Drawing.Size(75, 23);
            this.btnBack.TabIndex = 10;
            this.btnBack.Text = "Back";
            this.btnBack.UseVisualStyleBackColor = true;
            this.btnBack.Click += new System.EventHandler(this.btnBack_Click);
            // 
            // ForcedPractice
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.Controls.Add(this.btnBack);
            this.Controls.Add(this.lblIncorrect);
            this.Controls.Add(this.imgIncorrect);
            this.Controls.Add(this.btnNext);
            this.Controls.Add(this.pbRound);
            this.Controls.Add(this.pbSessionProgress);
            this.Controls.Add(this.lblEntity);
            this.Controls.Add(this.tbEntry);
            this.Controls.Add(this.label3);
            this.Controls.Add(this.lblRound);
            this.Controls.Add(this.lblSessionProgress);
            this.Name = "ForcedPractice";
            this.Load += new System.EventHandler(this.ForcedPractice_Load);
            ((System.ComponentModel.ISupportInitialize)(this.imgIncorrect)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Label lblSessionProgress;
        private System.Windows.Forms.Label lblRound;
        private System.Windows.Forms.Label label3;
        private CueTextBox tbEntry;
        private System.Windows.Forms.Label lblEntity;
        private System.Windows.Forms.ProgressBar pbSessionProgress;
        private System.Windows.Forms.ProgressBar pbRound;
        private System.Windows.Forms.Button btnNext;
        private System.Windows.Forms.PictureBox imgIncorrect;
        private System.Windows.Forms.Label lblIncorrect;
        private System.Windows.Forms.ImageList imageList1;
        private System.Windows.Forms.Button btnBack;
    }
}