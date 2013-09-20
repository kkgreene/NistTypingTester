using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace TypingTester
{
    public sealed class Options
    {
        private static readonly Options _instance = new Options();

        private List<string> _includeFilters = new List<string>();
        private List<string> _excludeFilters = new List<string>();
        
        public int NumberOfEntities { get; set; }
        public int RepetitionPerEntity { get; set; }
        public int ForcedPracticeRounds { get; set; }
        public int VerifyRounds { get; set; }
        public bool RandomEntityOrder { get; set; }
        public bool UseOrderSeed { get; set; }
        public int OrderSeed { get; set; }
        public bool RandomEntitySelection { get; set; }
        public bool UseSelectionSeed { get; set; }
        public int SelectionSeed { get; set; }
        public bool UseGroupId { get; set; }
        public int GroupId { get; set; }
        public string QuitString { get; set; }
        public string SkipString { get; set; }
 
        public string[] IncludeFilters
        {
            get
            {
                return _includeFilters.ToArray();
            }
            set
            {
                _includeFilters.Clear();
                _includeFilters.AddRange(value);
            }
        }

        public string[] ExcludeFilters
        {
            get
            {
                return _excludeFilters.ToArray();
            }
            set
            {
                _excludeFilters.Clear();
                _excludeFilters.AddRange(value);
            }
        }


        private Options()
        {
            this.NumberOfEntities = 10;
            this.RepetitionPerEntity = 10;
            this.ForcedPracticeRounds = 3;
            this.RandomEntityOrder = false;
            this.UseOrderSeed = false;
            this.OrderSeed = 1;
            this.RandomEntitySelection = false;
            this.UseSelectionSeed = false;
            this.SelectionSeed = 1;
            this.UseGroupId = false;
            this.GroupId = 1;
            this.QuitString = "I QUIT";
            this.VerifyRounds = 1;
            this.SkipString = "I SKIP";

        }

        public static Options Instance
        {
            get
            {
                return _instance;
            }
        }

        public static void ResetToDefault()
        { 
            
        }

        
    }
}
