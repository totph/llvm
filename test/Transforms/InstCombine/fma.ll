; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -S -instcombine < %s | FileCheck %s

declare float @llvm.fma.f32(float, float, float) #1
declare <2 x float> @llvm.fma.v2f32(<2 x float>, <2 x float>, <2 x float>) #1
declare float @llvm.fmuladd.f32(float, float, float) #1
declare float @llvm.fabs.f32(float) #1

@external = external global i32

define float @fma_fneg_x_fneg_y(float %x, float %y, float %z) {
; CHECK-LABEL: @fma_fneg_x_fneg_y(
; CHECK-NEXT:    [[FMA:%.*]] = call float @llvm.fma.f32(float [[X:%.*]], float [[Y:%.*]], float [[Z:%.*]])
; CHECK-NEXT:    ret float [[FMA]]
;
  %x.fneg = fsub float -0.0, %x
  %y.fneg = fsub float -0.0, %y
  %fma = call float @llvm.fma.f32(float %x.fneg, float %y.fneg, float %z)
  ret float %fma
}

define float @fma_unary_fneg_x_unary_fneg_y(float %x, float %y, float %z) {
; CHECK-LABEL: @fma_unary_fneg_x_unary_fneg_y(
; CHECK-NEXT:    [[FMA:%.*]] = call float @llvm.fma.f32(float [[X:%.*]], float [[Y:%.*]], float [[Z:%.*]])
; CHECK-NEXT:    ret float [[FMA]]
;
  %x.fneg = fneg float %x
  %y.fneg = fneg float %y
  %fma = call float @llvm.fma.f32(float %x.fneg, float %y.fneg, float %z)
  ret float %fma
}

define <2 x float> @fma_fneg_x_fneg_y_vec(<2 x float> %x, <2 x float> %y, <2 x float> %z) {
; CHECK-LABEL: @fma_fneg_x_fneg_y_vec(
; CHECK-NEXT:    [[FMA:%.*]] = call <2 x float> @llvm.fma.v2f32(<2 x float> [[X:%.*]], <2 x float> [[Y:%.*]], <2 x float> [[Z:%.*]])
; CHECK-NEXT:    ret <2 x float> [[FMA]]
;
  %xn = fsub <2 x float> <float -0.0, float -0.0>, %x
  %yn = fsub <2 x float> <float -0.0, float -0.0>, %y
  %fma = call <2 x float> @llvm.fma.v2f32(<2 x float> %xn, <2 x float> %yn, <2 x float> %z)
  ret <2 x float> %fma
}

define <2 x float> @fma_unary_fneg_x_unary_fneg_y_vec(<2 x float> %x, <2 x float> %y, <2 x float> %z) {
; CHECK-LABEL: @fma_unary_fneg_x_unary_fneg_y_vec(
; CHECK-NEXT:    [[FMA:%.*]] = call <2 x float> @llvm.fma.v2f32(<2 x float> [[X:%.*]], <2 x float> [[Y:%.*]], <2 x float> [[Z:%.*]])
; CHECK-NEXT:    ret <2 x float> [[FMA]]
;
  %xn = fneg <2 x float> %x
  %yn = fneg <2 x float> %y
  %fma = call <2 x float> @llvm.fma.v2f32(<2 x float> %xn, <2 x float> %yn, <2 x float> %z)
  ret <2 x float> %fma
}

define <2 x float> @fma_fneg_x_fneg_y_vec_undef(<2 x float> %x, <2 x float> %y, <2 x float> %z) {
; CHECK-LABEL: @fma_fneg_x_fneg_y_vec_undef(
; CHECK-NEXT:    [[FMA:%.*]] = call <2 x float> @llvm.fma.v2f32(<2 x float> [[X:%.*]], <2 x float> [[Y:%.*]], <2 x float> [[Z:%.*]])
; CHECK-NEXT:    ret <2 x float> [[FMA]]
;
  %xn = fsub <2 x float> <float -0.0, float undef>, %x
  %yn = fsub <2 x float> <float undef, float -0.0>, %y
  %fma = call <2 x float> @llvm.fma.v2f32(<2 x float> %xn, <2 x float> %yn, <2 x float> %z)
  ret <2 x float> %fma
}

define float @fma_fneg_x_fneg_y_fast(float %x, float %y, float %z) {
; CHECK-LABEL: @fma_fneg_x_fneg_y_fast(
; CHECK-NEXT:    [[FMA:%.*]] = call fast float @llvm.fma.f32(float [[X:%.*]], float [[Y:%.*]], float [[Z:%.*]])
; CHECK-NEXT:    ret float [[FMA]]
;
  %x.fneg = fsub float -0.0, %x
  %y.fneg = fsub float -0.0, %y
  %fma = call fast float @llvm.fma.f32(float %x.fneg, float %y.fneg, float %z)
  ret float %fma
}

define float @fma_unary_fneg_x_unary_fneg_y_fast(float %x, float %y, float %z) {
; CHECK-LABEL: @fma_unary_fneg_x_unary_fneg_y_fast(
; CHECK-NEXT:    [[FMA:%.*]] = call fast float @llvm.fma.f32(float [[X:%.*]], float [[Y:%.*]], float [[Z:%.*]])
; CHECK-NEXT:    ret float [[FMA]]
;
  %x.fneg = fneg float %x
  %y.fneg = fneg float %y
  %fma = call fast float @llvm.fma.f32(float %x.fneg, float %y.fneg, float %z)
  ret float %fma
}

define float @fma_fneg_const_fneg_y(float %y, float %z) {
; CHECK-LABEL: @fma_fneg_const_fneg_y(
; CHECK-NEXT:    [[FMA:%.*]] = call float @llvm.fma.f32(float [[Y:%.*]], float bitcast (i32 ptrtoint (i32* @external to i32) to float), float [[Z:%.*]])
; CHECK-NEXT:    ret float [[FMA]]
;
  %y.fneg = fsub float -0.0, %y
  %fma = call float @llvm.fma.f32(float fsub (float -0.0, float bitcast (i32 ptrtoint (i32* @external to i32) to float)), float %y.fneg, float %z)
  ret float %fma
}

define float @fma_unary_fneg_const_unary_fneg_y(float %y, float %z) {
; CHECK-LABEL: @fma_unary_fneg_const_unary_fneg_y(
; CHECK-NEXT:    [[FMA:%.*]] = call float @llvm.fma.f32(float [[Y:%.*]], float bitcast (i32 ptrtoint (i32* @external to i32) to float), float [[Z:%.*]])
; CHECK-NEXT:    ret float [[FMA]]
;
  %y.fneg = fneg float %y
  %fma = call float @llvm.fma.f32(float fneg (float bitcast (i32 ptrtoint (i32* @external to i32) to float)), float %y.fneg, float %z)
  ret float %fma
}

define float @fma_fneg_x_fneg_const(float %x, float %z) {
; CHECK-LABEL: @fma_fneg_x_fneg_const(
; CHECK-NEXT:    [[FMA:%.*]] = call float @llvm.fma.f32(float [[X:%.*]], float bitcast (i32 ptrtoint (i32* @external to i32) to float), float [[Z:%.*]])
; CHECK-NEXT:    ret float [[FMA]]
;
  %x.fneg = fsub float -0.0, %x
  %fma = call float @llvm.fma.f32(float %x.fneg, float fsub (float -0.0, float bitcast (i32 ptrtoint (i32* @external to i32) to float)), float %z)
  ret float %fma
}

define float @fma_unary_fneg_x_unary_fneg_const(float %x, float %z) {
; CHECK-LABEL: @fma_unary_fneg_x_unary_fneg_const(
; CHECK-NEXT:    [[FMA:%.*]] = call float @llvm.fma.f32(float [[X:%.*]], float bitcast (i32 ptrtoint (i32* @external to i32) to float), float [[Z:%.*]])
; CHECK-NEXT:    ret float [[FMA]]
;
  %x.fneg = fneg float %x
  %fma = call float @llvm.fma.f32(float %x.fneg, float fneg (float bitcast (i32 ptrtoint (i32* @external to i32) to float)), float %z)
  ret float %fma
}

define float @fma_fabs_x_fabs_y(float %x, float %y, float %z) {
; CHECK-LABEL: @fma_fabs_x_fabs_y(
; CHECK-NEXT:    [[X_FABS:%.*]] = call float @llvm.fabs.f32(float [[X:%.*]])
; CHECK-NEXT:    [[Y_FABS:%.*]] = call float @llvm.fabs.f32(float [[Y:%.*]])
; CHECK-NEXT:    [[FMA:%.*]] = call float @llvm.fma.f32(float [[X_FABS]], float [[Y_FABS]], float [[Z:%.*]])
; CHECK-NEXT:    ret float [[FMA]]
;
  %x.fabs = call float @llvm.fabs.f32(float %x)
  %y.fabs = call float @llvm.fabs.f32(float %y)
  %fma = call float @llvm.fma.f32(float %x.fabs, float %y.fabs, float %z)
  ret float %fma
}

define float @fma_fabs_x_fabs_x(float %x, float %z) {
; CHECK-LABEL: @fma_fabs_x_fabs_x(
; CHECK-NEXT:    [[FMA:%.*]] = call float @llvm.fma.f32(float [[X:%.*]], float [[X]], float [[Z:%.*]])
; CHECK-NEXT:    ret float [[FMA]]
;
  %x.fabs = call float @llvm.fabs.f32(float %x)
  %fma = call float @llvm.fma.f32(float %x.fabs, float %x.fabs, float %z)
  ret float %fma
}

define float @fma_fabs_x_fabs_x_fast(float %x, float %z) {
; CHECK-LABEL: @fma_fabs_x_fabs_x_fast(
; CHECK-NEXT:    [[FMA:%.*]] = call fast float @llvm.fma.f32(float [[X:%.*]], float [[X]], float [[Z:%.*]])
; CHECK-NEXT:    ret float [[FMA]]
;
  %x.fabs = call float @llvm.fabs.f32(float %x)
  %fma = call fast float @llvm.fma.f32(float %x.fabs, float %x.fabs, float %z)
  ret float %fma
}

define float @fmuladd_fneg_x_fneg_y(float %x, float %y, float %z) {
; CHECK-LABEL: @fmuladd_fneg_x_fneg_y(
; CHECK-NEXT:    [[FMULADD:%.*]] = call float @llvm.fmuladd.f32(float [[X:%.*]], float [[Y:%.*]], float [[Z:%.*]])
; CHECK-NEXT:    ret float [[FMULADD]]
;
  %x.fneg = fsub float -0.0, %x
  %y.fneg = fsub float -0.0, %y
  %fmuladd = call float @llvm.fmuladd.f32(float %x.fneg, float %y.fneg, float %z)
  ret float %fmuladd
}

define float @fmuladd_unary_fneg_x_unary_fneg_y(float %x, float %y, float %z) {
; CHECK-LABEL: @fmuladd_unary_fneg_x_unary_fneg_y(
; CHECK-NEXT:    [[FMULADD:%.*]] = call float @llvm.fmuladd.f32(float [[X:%.*]], float [[Y:%.*]], float [[Z:%.*]])
; CHECK-NEXT:    ret float [[FMULADD]]
;
  %x.fneg = fneg float %x
  %y.fneg = fneg float %y
  %fmuladd = call float @llvm.fmuladd.f32(float %x.fneg, float %y.fneg, float %z)
  ret float %fmuladd
}

define float @fmuladd_fneg_x_fneg_y_fast(float %x, float %y, float %z) {
; CHECK-LABEL: @fmuladd_fneg_x_fneg_y_fast(
; CHECK-NEXT:    [[TMP1:%.*]] = fmul fast float [[X:%.*]], [[Y:%.*]]
; CHECK-NEXT:    [[FMULADD:%.*]] = fadd fast float [[TMP1]], [[Z:%.*]]
; CHECK-NEXT:    ret float [[FMULADD]]
;
  %x.fneg = fsub float -0.0, %x
  %y.fneg = fsub float -0.0, %y
  %fmuladd = call fast float @llvm.fmuladd.f32(float %x.fneg, float %y.fneg, float %z)
  ret float %fmuladd
}

define float @fmuladd_unary_fneg_x_unary_fneg_y_fast(float %x, float %y, float %z) {
; CHECK-LABEL: @fmuladd_unary_fneg_x_unary_fneg_y_fast(
; CHECK-NEXT:    [[TMP1:%.*]] = fmul fast float [[X:%.*]], [[Y:%.*]]
; CHECK-NEXT:    [[FMULADD:%.*]] = fadd fast float [[TMP1]], [[Z:%.*]]
; CHECK-NEXT:    ret float [[FMULADD]]
;
  %x.fneg = fneg float %x
  %y.fneg = fneg float %y
  %fmuladd = call fast float @llvm.fmuladd.f32(float %x.fneg, float %y.fneg, float %z)
  ret float %fmuladd
}

define float @fmuladd_fneg_const_fneg_y(float %y, float %z) {
; CHECK-LABEL: @fmuladd_fneg_const_fneg_y(
; CHECK-NEXT:    [[FMULADD:%.*]] = call float @llvm.fmuladd.f32(float [[Y:%.*]], float bitcast (i32 ptrtoint (i32* @external to i32) to float), float [[Z:%.*]])
; CHECK-NEXT:    ret float [[FMULADD]]
;
  %y.fneg = fsub float -0.0, %y
  %fmuladd = call float @llvm.fmuladd.f32(float fsub (float -0.0, float bitcast (i32 ptrtoint (i32* @external to i32) to float)), float %y.fneg, float %z)
  ret float %fmuladd
}

define float @fmuladd_unary_fneg_const_unary_fneg_y(float %y, float %z) {
; CHECK-LABEL: @fmuladd_unary_fneg_const_unary_fneg_y(
; CHECK-NEXT:    [[FMULADD:%.*]] = call float @llvm.fmuladd.f32(float [[Y:%.*]], float bitcast (i32 ptrtoint (i32* @external to i32) to float), float [[Z:%.*]])
; CHECK-NEXT:    ret float [[FMULADD]]
;
  %y.fneg = fneg float %y
  %fmuladd = call float @llvm.fmuladd.f32(float fneg (float bitcast (i32 ptrtoint (i32* @external to i32) to float)), float %y.fneg, float %z)
  ret float %fmuladd
}

define float @fmuladd_fneg_x_fneg_const(float %x, float %z) {
; CHECK-LABEL: @fmuladd_fneg_x_fneg_const(
; CHECK-NEXT:    [[FMULADD:%.*]] = call float @llvm.fmuladd.f32(float [[X:%.*]], float bitcast (i32 ptrtoint (i32* @external to i32) to float), float [[Z:%.*]])
; CHECK-NEXT:    ret float [[FMULADD]]
;
  %x.fneg = fsub float -0.0, %x
  %fmuladd = call float @llvm.fmuladd.f32(float %x.fneg, float fsub (float -0.0, float bitcast (i32 ptrtoint (i32* @external to i32) to float)), float %z)
  ret float %fmuladd
}

define float @fmuladd_unary_fneg_x_unary_fneg_const(float %x, float %z) {
; CHECK-LABEL: @fmuladd_unary_fneg_x_unary_fneg_const(
; CHECK-NEXT:    [[FMULADD:%.*]] = call float @llvm.fmuladd.f32(float [[X:%.*]], float bitcast (i32 ptrtoint (i32* @external to i32) to float), float [[Z:%.*]])
; CHECK-NEXT:    ret float [[FMULADD]]
;
  %x.fneg = fneg float %x
  %fmuladd = call float @llvm.fmuladd.f32(float %x.fneg, float fneg (float bitcast (i32 ptrtoint (i32* @external to i32) to float)), float %z)
  ret float %fmuladd
}

define float @fmuladd_fabs_x_fabs_y(float %x, float %y, float %z) {
; CHECK-LABEL: @fmuladd_fabs_x_fabs_y(
; CHECK-NEXT:    [[X_FABS:%.*]] = call float @llvm.fabs.f32(float [[X:%.*]])
; CHECK-NEXT:    [[Y_FABS:%.*]] = call float @llvm.fabs.f32(float [[Y:%.*]])
; CHECK-NEXT:    [[FMULADD:%.*]] = call float @llvm.fmuladd.f32(float [[X_FABS]], float [[Y_FABS]], float [[Z:%.*]])
; CHECK-NEXT:    ret float [[FMULADD]]
;
  %x.fabs = call float @llvm.fabs.f32(float %x)
  %y.fabs = call float @llvm.fabs.f32(float %y)
  %fmuladd = call float @llvm.fmuladd.f32(float %x.fabs, float %y.fabs, float %z)
  ret float %fmuladd
}

define float @fmuladd_fabs_x_fabs_x(float %x, float %z) {
; CHECK-LABEL: @fmuladd_fabs_x_fabs_x(
; CHECK-NEXT:    [[FMULADD:%.*]] = call float @llvm.fmuladd.f32(float [[X:%.*]], float [[X]], float [[Z:%.*]])
; CHECK-NEXT:    ret float [[FMULADD]]
;
  %x.fabs = call float @llvm.fabs.f32(float %x)
  %fmuladd = call float @llvm.fmuladd.f32(float %x.fabs, float %x.fabs, float %z)
  ret float %fmuladd
}

define float @fmuladd_fabs_x_fabs_x_fast(float %x, float %z) {
; CHECK-LABEL: @fmuladd_fabs_x_fabs_x_fast(
; CHECK-NEXT:    [[TMP1:%.*]] = fmul fast float [[X:%.*]], [[X]]
; CHECK-NEXT:    [[FMULADD:%.*]] = fadd fast float [[TMP1]], [[Z:%.*]]
; CHECK-NEXT:    ret float [[FMULADD]]
;
  %x.fabs = call float @llvm.fabs.f32(float %x)
  %fmuladd = call fast float @llvm.fmuladd.f32(float %x.fabs, float %x.fabs, float %z)
  ret float %fmuladd
}

define float @fma_k_y_z(float %y, float %z) {
; CHECK-LABEL: @fma_k_y_z(
; CHECK-NEXT:    [[FMA:%.*]] = call float @llvm.fma.f32(float [[Y:%.*]], float 4.000000e+00, float [[Z:%.*]])
; CHECK-NEXT:    ret float [[FMA]]
;
  %fma = call float @llvm.fma.f32(float 4.0, float %y, float %z)
  ret float %fma
}

define float @fma_k_y_z_fast(float %y, float %z) {
; CHECK-LABEL: @fma_k_y_z_fast(
; CHECK-NEXT:    [[FMA:%.*]] = call fast float @llvm.fma.f32(float [[Y:%.*]], float 4.000000e+00, float [[Z:%.*]])
; CHECK-NEXT:    ret float [[FMA]]
;
  %fma = call fast float @llvm.fma.f32(float 4.0, float %y, float %z)
  ret float %fma
}

define float @fmuladd_k_y_z_fast(float %y, float %z) {
; CHECK-LABEL: @fmuladd_k_y_z_fast(
; CHECK-NEXT:    [[TMP1:%.*]] = fmul fast float [[Y:%.*]], 4.000000e+00
; CHECK-NEXT:    [[FMULADD:%.*]] = fadd fast float [[TMP1]], [[Z:%.*]]
; CHECK-NEXT:    ret float [[FMULADD]]
;
  %fmuladd = call fast float @llvm.fmuladd.f32(float 4.0, float %y, float %z)
  ret float %fmuladd
}

define float @fma_1_y_z(float %y, float %z) {
; CHECK-LABEL: @fma_1_y_z(
; CHECK-NEXT:    [[FMA:%.*]] = fadd float [[Y:%.*]], [[Z:%.*]]
; CHECK-NEXT:    ret float [[FMA]]
;
  %fma = call float @llvm.fma.f32(float 1.0, float %y, float %z)
  ret float %fma
}

define float @fma_x_1_z(float %x, float %z) {
; CHECK-LABEL: @fma_x_1_z(
; CHECK-NEXT:    [[FMA:%.*]] = fadd float [[X:%.*]], [[Z:%.*]]
; CHECK-NEXT:    ret float [[FMA]]
;
  %fma = call float @llvm.fma.f32(float %x, float 1.0, float %z)
  ret float %fma
}

define <2 x float> @fma_x_1_z_v2f32(<2 x float> %x, <2 x float> %z) {
; CHECK-LABEL: @fma_x_1_z_v2f32(
; CHECK-NEXT:    [[FMA:%.*]] = fadd <2 x float> [[X:%.*]], [[Z:%.*]]
; CHECK-NEXT:    ret <2 x float> [[FMA]]
;
  %fma = call <2 x float> @llvm.fma.v2f32(<2 x float> %x, <2 x float> <float 1.0, float 1.0>, <2 x float> %z)
  ret <2 x float> %fma
}

define <2 x float> @fma_x_1_2_z_v2f32(<2 x float> %x, <2 x float> %z) {
; CHECK-LABEL: @fma_x_1_2_z_v2f32(
; CHECK-NEXT:    [[FMA:%.*]] = call <2 x float> @llvm.fma.v2f32(<2 x float> [[X:%.*]], <2 x float> <float 1.000000e+00, float 2.000000e+00>, <2 x float> [[Z:%.*]])
; CHECK-NEXT:    ret <2 x float> [[FMA]]
;
  %fma = call <2 x float> @llvm.fma.v2f32(<2 x float> %x, <2 x float> <float 1.0, float 2.0>, <2 x float> %z)
  ret <2 x float> %fma
}

define float @fma_x_1_z_fast(float %x, float %z) {
; CHECK-LABEL: @fma_x_1_z_fast(
; CHECK-NEXT:    [[FMA:%.*]] = fadd fast float [[X:%.*]], [[Z:%.*]]
; CHECK-NEXT:    ret float [[FMA]]
;
  %fma = call fast float @llvm.fma.f32(float %x, float 1.0, float %z)
  ret float %fma
}

define float @fma_1_1_z(float %z) {
; CHECK-LABEL: @fma_1_1_z(
; CHECK-NEXT:    [[FMA:%.*]] = fadd float [[Z:%.*]], 1.000000e+00
; CHECK-NEXT:    ret float [[FMA]]
;
  %fma = call float @llvm.fma.f32(float 1.0, float 1.0, float %z)
  ret float %fma
}

define float @fmuladd_x_1_z_fast(float %x, float %z) {
; CHECK-LABEL: @fmuladd_x_1_z_fast(
; CHECK-NEXT:    [[FMULADD:%.*]] = fadd fast float [[X:%.*]], [[Z:%.*]]
; CHECK-NEXT:    ret float [[FMULADD]]
;
  %fmuladd = call fast float @llvm.fmuladd.f32(float %x, float 1.0, float %z)
  ret float %fmuladd
}

define <2 x double> @fmuladd_a_0_b(<2 x double> %a, <2 x double> %b) {
; CHECK-LABEL: @fmuladd_a_0_b(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    ret <2 x double> [[B:%.*]]
;
entry:
  %res = call nnan nsz <2 x double> @llvm.fmuladd.v2f64(<2 x double> %a, <2 x double> zeroinitializer, <2 x double> %b)
  ret <2 x double> %res
}

define <2 x double> @fmuladd_0_a_b(<2 x double> %a, <2 x double> %b) {
; CHECK-LABEL: @fmuladd_0_a_b(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    ret <2 x double> [[B:%.*]]
;
entry:
  %res = call nnan nsz <2 x double> @llvm.fmuladd.v2f64(<2 x double> zeroinitializer, <2 x double> %a, <2 x double> %b)
  ret <2 x double> %res
}

define <2 x double> @fmuladd_a_0_b_missing_flags(<2 x double> %a, <2 x double> %b) {
; CHECK-LABEL: @fmuladd_a_0_b_missing_flags(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[RES:%.*]] = call nnan <2 x double> @llvm.fmuladd.v2f64(<2 x double> [[A:%.*]], <2 x double> zeroinitializer, <2 x double> [[B:%.*]])
; CHECK-NEXT:    ret <2 x double> [[RES]]
;
entry:
  %res = call nnan <2 x double> @llvm.fmuladd.v2f64(<2 x double> %a, <2 x double> zeroinitializer, <2 x double> %b)
  ret <2 x double> %res
}

declare <2 x double> @llvm.fmuladd.v2f64(<2 x double>, <2 x double>, <2 x double>)

define <2 x double> @fma_a_0_b(<2 x double> %a, <2 x double> %b) {
; CHECK-LABEL: @fma_a_0_b(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    ret <2 x double> [[B:%.*]]
;
entry:
  %res = call nnan nsz <2 x double> @llvm.fma.v2f64(<2 x double> %a, <2 x double> zeroinitializer, <2 x double> %b)
  ret <2 x double> %res
}

define <2 x double> @fma_0_a_b(<2 x double> %a, <2 x double> %b) {
; CHECK-LABEL: @fma_0_a_b(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    ret <2 x double> [[B:%.*]]
;
entry:
  %res = call nnan nsz <2 x double> @llvm.fma.v2f64(<2 x double> zeroinitializer, <2 x double> %a, <2 x double> %b)
  ret <2 x double> %res
}

define <2 x double> @fma_0_a_b_missing_flags(<2 x double> %a, <2 x double> %b) {
; CHECK-LABEL: @fma_0_a_b_missing_flags(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[RES:%.*]] = call nsz <2 x double> @llvm.fma.v2f64(<2 x double> [[A:%.*]], <2 x double> zeroinitializer, <2 x double> [[B:%.*]])
; CHECK-NEXT:    ret <2 x double> [[RES]]
;
entry:
  %res = call nsz <2 x double> @llvm.fma.v2f64(<2 x double> zeroinitializer, <2 x double> %a, <2 x double> %b)
  ret <2 x double> %res
}

define <2 x double> @fma_sqrt(<2 x double> %a, <2 x double> %b) {
; CHECK-LABEL: @fma_sqrt(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[RES:%.*]] = fadd fast <2 x double> [[A:%.*]], [[B:%.*]]
; CHECK-NEXT:    ret <2 x double> [[RES]]
;
entry:
  %sqrt = call fast <2 x double> @llvm.sqrt.v2f64(<2 x double> %a)
  %res = call fast <2 x double> @llvm.fma.v2f64(<2 x double> %sqrt, <2 x double> %sqrt, <2 x double> %b)
  ret <2 x double> %res
}

; We do not fold constant multiplies in FMAs, as they could require rounding, unless either constant is 0.0 or 1.0.
define <2 x double> @fma_const_fmul(<2 x double> %b) {
; CHECK-LABEL: @fma_const_fmul(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[RES:%.*]] = call nnan nsz <2 x double> @llvm.fma.v2f64(<2 x double> <double 0x4131233302898702, double 0x40C387800000D6C0>, <2 x double> <double 1.291820e-08, double 9.123000e-06>, <2 x double> [[B:%.*]])
; CHECK-NEXT:    ret <2 x double> [[RES]]
;
entry:
  %res = call nnan nsz <2 x double> @llvm.fma.v2f64(<2 x double> <double 1123123.0099110012314, double 9999.0000001>, <2 x double> <double 0.0000000129182, double 0.000009123>, <2 x double> %b)
  ret <2 x double> %res
}

define <2 x double> @fma_const_fmul_zero(<2 x double> %b) {
; CHECK-LABEL: @fma_const_fmul_zero(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[RES:%.*]] = call nnan nsz <2 x double> @llvm.fma.v2f64(<2 x double> zeroinitializer, <2 x double> <double 0x4131233302898702, double 0x40C387800000D6C0>, <2 x double> [[B:%.*]])
; CHECK-NEXT:    ret <2 x double> [[RES]]
;
entry:
  %res = call nnan nsz <2 x double> @llvm.fma.v2f64(<2 x double> <double 0.0, double 0.0>, <2 x double> <double 1123123.0099110012314, double 9999.0000001>, <2 x double> %b)
  ret <2 x double> %res
}

define <2 x double> @fma_const_fmul_zero2(<2 x double> %b) {
; CHECK-LABEL: @fma_const_fmul_zero2(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    ret <2 x double> [[B:%.*]]
;
entry:
  %res = call nnan nsz <2 x double> @llvm.fma.v2f64(<2 x double> <double 1123123.0099110012314, double 9999.0000001>, <2 x double> <double 0.0, double 0.0>, <2 x double> %b)
  ret <2 x double> %res
}

define <2 x double> @fma_const_fmul_one(<2 x double> %b) {
; CHECK-LABEL: @fma_const_fmul_one(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[RES:%.*]] = call nnan nsz <2 x double> @llvm.fma.v2f64(<2 x double> <double 1.000000e+00, double 1.000000e+00>, <2 x double> <double 0x4131233302898702, double 0x40C387800000D6C0>, <2 x double> [[B:%.*]])
; CHECK-NEXT:    ret <2 x double> [[RES]]
;
entry:
  %res = call nnan nsz <2 x double> @llvm.fma.v2f64(<2 x double> <double 1.0, double 1.0>, <2 x double> <double 1123123.0099110012314, double 9999.0000001>, <2 x double> %b)
  ret <2 x double> %res
}

define <2 x double> @fma_const_fmul_one2(<2 x double> %b) {
; CHECK-LABEL: @fma_const_fmul_one2(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[RES:%.*]] = fadd nnan nsz <2 x double> [[B:%.*]], <double 0x4131233302898702, double 0x40C387800000D6C0>
; CHECK-NEXT:    ret <2 x double> [[RES]]
;
entry:
  %res = call nnan nsz <2 x double> @llvm.fma.v2f64(<2 x double> <double 1123123.0099110012314, double 9999.0000001>, <2 x double> <double 1.0, double 1.0>, <2 x double> %b)
  ret <2 x double> %res
}

define <2 x double> @fmuladd_const_fmul(<2 x double> %b) {
; CHECK-LABEL: @fmuladd_const_fmul(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[RES:%.*]] = fadd nnan nsz <2 x double> [[B:%.*]], <double 0x3F8DB6C076AD949B, double 0x3FB75A405B6E6D69>
; CHECK-NEXT:    ret <2 x double> [[RES]]
;
entry:
  %res = call nnan nsz <2 x double> @llvm.fmuladd.v2f64(<2 x double> <double 1123123.0099110012314, double 9999.0000001>, <2 x double> <double 0.0000000129182, double 0.000009123>, <2 x double> %b)
  ret <2 x double> %res
}

declare <2 x double> @llvm.fma.v2f64(<2 x double>, <2 x double>, <2 x double>)
declare <2 x double> @llvm.sqrt.v2f64(<2 x double>)


attributes #0 = { nounwind }
attributes #1 = { nounwind readnone }
