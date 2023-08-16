#ifndef TRITON_GPU_DIALECT_INTERFACES
#define TRITON_GPU_DIALECT_INTERFACES

include "mlir/IR/OpBase.td"

def TritonGPUDistributedLayout : AttrInterface<"TritonGPUDistributedLayout"> {
  let cppNamespace = "::mlir::triton::gpu";

  let methods = [
    // CTA cluster interface
    InterfaceMethod<"return getNumCTAs.", "unsigned",
      "getNumCTAs">,
    InterfaceMethod<"return getCTASplitNum.", "SmallVector<unsigned>",
      "getCTASplitNum">,
    InterfaceMethod<"return getCTAsPerCGA.", "SmallVector<unsigned>",
      "getCTAsPerCGA">,
    InterfaceMethod<"return getCTAOrder.", "SmallVector<unsigned>",
      "getCTAOrder">,
    InterfaceMethod<"return getCTALayout.", "Attribute",
      "getCTALayout">,

    // items per thread
    InterfaceMethod<"Return element size per thread.", "SmallVector<unsigned>",
      "getElemsPerThread", (ins "ArrayRef<int64_t>":$tensorShape,
                                "Type":$eltTy)>,
    InterfaceMethod<"Return total element size per thread.", "unsigned",
      "getTotalElemsPerThread", (ins "ArrayRef<int64_t>":$tensorShape,
                                "Type":$eltTy)>,

    // threads per warp
    InterfaceMethod<"return getThreadsPerWarp.", "SmallVector<unsigned>",
      "getThreadsPerWarp">,

    InterfaceMethod<"Return shape per CTA.", "SmallVector<unsigned>",
      "getShapePerCTATile", (ins "ArrayRef<int64_t>":$tensorShape)>,

    // size per threads
    InterfaceMethod<"Return shared shape per thread.", "SmallVector<unsigned>",
      "getSizePerThread">,
  ];
}

def TritonGPUMMAAttrInterface : AttrInterface<"TritonGPUMMAAttrInterface"> {
  let cppNamespace = "::mlir::triton::gpu";
  let methods = [
    InterfaceMethod<"Return total element size per thread.", "ArrayRef<unsigned>",
      "getWarpsPerCTA">,

    InterfaceMethod<"Return shape per CTA.", "SmallVector<unsigned>",
      "getShapePerCTATileForDotOperands", (ins "ArrayRef<int64_t>":$tensorShape,
                                               "unsigned":$opIdx)>,

    InterfaceMethod<"Return total element size per thread for A.", "unsigned",
      "getTotalElemsPerThreadForOperands", (ins "ArrayRef<int64_t>":$tensorShape,
                                                "Type":$eltTy,
                                                "unsigned":$opIdx)>,

    InterfaceMethod<"Return shared shape per thread.", "SmallVector<unsigned>",
      "getSizePerThreadForOperands", (ins "unsigned":$opIdx)>,
  ];
}

#endif // TRITON_GPU_DIALECT_INTERFACES
