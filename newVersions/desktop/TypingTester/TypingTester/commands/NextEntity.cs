﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace TypingTester.commands
{
    class NextEntity : Command
    {
        private BaseForm _reciever;

        public NextEntity(BaseForm reciever)
        {
            _reciever = reciever;
        }

        protected override void Dispose(bool disposing)
        {
            if (!this.disposed)
            {
                if (disposing)
                {
                    _reciever = null;
                }
                this.disposed = true;
            }
        }

        public override void execute()
        {
            Session.Instance.CurrentEntity++;
            CommandGoToScreen cmd = new CommandGoToScreen(_reciever, Constants.Screen.Memorize);
            cmd.execute();
        }

        public override void undo()
        {
            throw new NotImplementedException();
        }
    }
}
