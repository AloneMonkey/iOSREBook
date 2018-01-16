#include "llvm/Pass.h"
#include "llvm/IR/Function.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/Analysis/LoopInfo.h"

using namespace llvm;

namespace{
    struct Hello : public FunctionPass{
        static char ID;
        
        Hello() : FunctionPass(ID){}
        
        virtual void getAnalysisUsage(AnalysisUsage &AU) const override{
            AU.addRequired<LoopInfoWrapperPass>();
            AU.setPreservesAll();
        }
        
        bool runOnFunction(Function &F) override{
            errs() << "Hello: ";
            errs().write_escaped(F.getName()) << "\n";
            
            LoopInfo &LI = getAnalysis<LoopInfoWrapperPass>().getLoopInfo();
            int loopCounter = 0;
            for (LoopInfo::iterator i = LI.begin(), e = LI.end(); i != e; ++i) {
                loopCounter++;
            }
            
            errs() << "loop num:" << loopCounter << "\n";
            
            return false;
        }
    };
}

char Hello::ID = 0;

static RegisterPass<Hello> X("hello", "hello world pass", false, false);
