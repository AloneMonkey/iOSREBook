add_llvm_loadable_module( LLVMPassDemo
  Hello.cpp

  DEPENDS
  intrinsics_gen
  PLUGIN_TOOL
  opt
  )