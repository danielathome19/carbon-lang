// Part of the Carbon Language project, under the Apache License v2.0 with LLVM
// Exceptions. See /LICENSE for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
// AUTOUPDATE

fn G() -> i32;

fn H() -> {.a: i32};

fn AddressOfLiteral() {
  // CHECK:STDERR: fail_address_of_value.carbon:[[@LINE+3]]:3: ERROR: Cannot take the address of non-reference expression.
  // CHECK:STDERR:   &0;
  // CHECK:STDERR:   ^
  &0;
  // CHECK:STDERR: fail_address_of_value.carbon:[[@LINE+3]]:3: ERROR: Cannot take the address of non-reference expression.
  // CHECK:STDERR:   &true;
  // CHECK:STDERR:   ^
  &true;
  // CHECK:STDERR: fail_address_of_value.carbon:[[@LINE+3]]:3: ERROR: Cannot take the address of non-reference expression.
  // CHECK:STDERR:   &1.0;
  // CHECK:STDERR:   ^
  &1.0;
  // CHECK:STDERR: fail_address_of_value.carbon:[[@LINE+3]]:3: ERROR: Cannot take the address of non-reference expression.
  // CHECK:STDERR:   &"Hello";
  // CHECK:STDERR:   ^
  &"Hello";
  // CHECK:STDERR: fail_address_of_value.carbon:[[@LINE+3]]:3: ERROR: Cannot take the address of non-reference expression.
  // CHECK:STDERR:   &(1, 2);
  // CHECK:STDERR:   ^
  &(1, 2);
  // CHECK:STDERR: fail_address_of_value.carbon:[[@LINE+3]]:3: ERROR: Cannot take the address of non-reference expression.
  // CHECK:STDERR:   &{.a = 5};
  // CHECK:STDERR:   ^
  &{.a = 5};
}

fn AddressOfOperator() {
  // CHECK:STDERR: fail_address_of_value.carbon:[[@LINE+3]]:3: ERROR: Cannot take the address of non-reference expression.
  // CHECK:STDERR:   &(true and false);
  // CHECK:STDERR:   ^
  &(true and false);
  // CHECK:STDERR: fail_address_of_value.carbon:[[@LINE+3]]:3: ERROR: Cannot take the address of a temporary object.
  // CHECK:STDERR:   &H().a;
  // CHECK:STDERR:   ^
  &H().a;
  // CHECK:STDERR: fail_address_of_value.carbon:[[@LINE+3]]:3: ERROR: Cannot take the address of non-reference expression.
  // CHECK:STDERR:   &(not true);
  // CHECK:STDERR:   ^
  &(not true);
}

fn AddressOfCall() {
  // CHECK:STDERR: fail_address_of_value.carbon:[[@LINE+3]]:3: ERROR: Cannot take the address of non-reference expression.
  // CHECK:STDERR:   &G();
  // CHECK:STDERR:   ^
  &G();
}

fn AddressOfType() {
  // CHECK:STDERR: fail_address_of_value.carbon:[[@LINE+3]]:3: ERROR: Cannot take the address of non-reference expression.
  // CHECK:STDERR:   &i32;
  // CHECK:STDERR:   ^
  &i32;
  // CHECK:STDERR: fail_address_of_value.carbon:[[@LINE+3]]:3: ERROR: Cannot take the address of non-reference expression.
  // CHECK:STDERR:   &(const i32*);
  // CHECK:STDERR:   ^
  &(const i32*);
}

fn AddressOfTupleElementValue() {
  // CHECK:STDERR: fail_address_of_value.carbon:[[@LINE+3]]:3: ERROR: Cannot take the address of non-reference expression.
  // CHECK:STDERR:   &((1, 2)[0]);
  // CHECK:STDERR:   ^
  &((1, 2)[0]);
}

fn AddressOfParam(param: i32) {
  // CHECK:STDERR: fail_address_of_value.carbon:[[@LINE+3]]:26: ERROR: Cannot take the address of non-reference expression.
  // CHECK:STDERR:   var param_addr: i32* = &param;
  // CHECK:STDERR:                          ^
  var param_addr: i32* = &param;
}

// CHECK:STDOUT: --- fail_address_of_value.carbon
// CHECK:STDOUT:
// CHECK:STDOUT: constants {
// CHECK:STDOUT:   %.loc15: type = ptr_type i32
// CHECK:STDOUT:   %.loc19: type = ptr_type bool
// CHECK:STDOUT:   %.loc23: type = ptr_type f64
// CHECK:STDOUT:   %.1: type = ptr_type String
// CHECK:STDOUT:   %.loc31_9: type = tuple_type (i32, i32)
// CHECK:STDOUT:   %.loc31_3: type = ptr_type (i32, i32)
// CHECK:STDOUT:   %.loc35: type = ptr_type {.a: i32}
// CHECK:STDOUT:   %.loc64: type = ptr_type type
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: file {
// CHECK:STDOUT:   package: <namespace> = namespace package, {.G = %G, .H = %H, .AddressOfLiteral = %AddressOfLiteral, .AddressOfOperator = %AddressOfOperator, .AddressOfCall = %AddressOfCall, .AddressOfType = %AddressOfType, .AddressOfTupleElementValue = %AddressOfTupleElementValue, .AddressOfParam = %AddressOfParam}
// CHECK:STDOUT:   %G: <function> = fn_decl @G
// CHECK:STDOUT:   %H: <function> = fn_decl @H
// CHECK:STDOUT:   %AddressOfLiteral: <function> = fn_decl @AddressOfLiteral
// CHECK:STDOUT:   %AddressOfOperator: <function> = fn_decl @AddressOfOperator
// CHECK:STDOUT:   %AddressOfCall: <function> = fn_decl @AddressOfCall
// CHECK:STDOUT:   %AddressOfType: <function> = fn_decl @AddressOfType
// CHECK:STDOUT:   %AddressOfTupleElementValue: <function> = fn_decl @AddressOfTupleElementValue
// CHECK:STDOUT:   %AddressOfParam: <function> = fn_decl @AddressOfParam
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: fn @G() -> i32;
// CHECK:STDOUT:
// CHECK:STDOUT: fn @H() -> {.a: i32};
// CHECK:STDOUT:
// CHECK:STDOUT: fn @AddressOfLiteral() {
// CHECK:STDOUT: !entry:
// CHECK:STDOUT:   %.loc15_4: i32 = int_literal 0
// CHECK:STDOUT:   %.loc15_3: i32* = addr_of %.loc15_4
// CHECK:STDOUT:   %.loc19_4: bool = bool_literal true
// CHECK:STDOUT:   %.loc19_3: bool* = addr_of %.loc19_4
// CHECK:STDOUT:   %.loc23_4: f64 = real_literal 10e-1
// CHECK:STDOUT:   %.loc23_3: f64* = addr_of %.loc23_4
// CHECK:STDOUT:   %.loc27_4: String = string_literal "Hello"
// CHECK:STDOUT:   %.loc27_3: String* = addr_of %.loc27_4
// CHECK:STDOUT:   %.loc31_5: i32 = int_literal 1
// CHECK:STDOUT:   %.loc31_8: i32 = int_literal 2
// CHECK:STDOUT:   %.loc31_9: (i32, i32) = tuple_literal (%.loc31_5, %.loc31_8)
// CHECK:STDOUT:   %.loc31_3: (i32, i32)* = addr_of %.loc31_9
// CHECK:STDOUT:   %.loc35_10: i32 = int_literal 5
// CHECK:STDOUT:   %.loc35_11: {.a: i32} = struct_literal (%.loc35_10)
// CHECK:STDOUT:   %.loc35_3: {.a: i32}* = addr_of %.loc35_11
// CHECK:STDOUT:   return
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: fn @AddressOfOperator() {
// CHECK:STDOUT: !entry:
// CHECK:STDOUT:   %.loc42_5: bool = bool_literal true
// CHECK:STDOUT:   %.loc42_10.1: bool = bool_literal false
// CHECK:STDOUT:   if %.loc42_5 br !and.rhs else br !and.result(%.loc42_10.1)
// CHECK:STDOUT:
// CHECK:STDOUT: !and.rhs:
// CHECK:STDOUT:   %.loc42_14: bool = bool_literal false
// CHECK:STDOUT:   br !and.result(%.loc42_14)
// CHECK:STDOUT:
// CHECK:STDOUT: !and.result:
// CHECK:STDOUT:   %.loc42_10.2: bool = block_arg !and.result
// CHECK:STDOUT:   %.loc42_3: bool* = addr_of %.loc42_10.2
// CHECK:STDOUT:   %H.ref: <function> = name_ref H, file.%H
// CHECK:STDOUT:   %.loc46_5.1: init {.a: i32} = call %H.ref()
// CHECK:STDOUT:   %.loc46_5.2: ref {.a: i32} = temporary_storage
// CHECK:STDOUT:   %.loc46_5.3: ref {.a: i32} = temporary %.loc46_5.2, %.loc46_5.1
// CHECK:STDOUT:   %.loc46_7: ref i32 = struct_access %.loc46_5.3, element0
// CHECK:STDOUT:   %.loc46_3: i32* = addr_of %.loc46_7
// CHECK:STDOUT:   %.loc50_9: bool = bool_literal true
// CHECK:STDOUT:   %.loc50_5: bool = not %.loc50_9
// CHECK:STDOUT:   %.loc50_3: bool* = addr_of %.loc50_5
// CHECK:STDOUT:   return
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: fn @AddressOfCall() {
// CHECK:STDOUT: !entry:
// CHECK:STDOUT:   %G.ref: <function> = name_ref G, file.%G
// CHECK:STDOUT:   %.loc57_5: init i32 = call %G.ref()
// CHECK:STDOUT:   %.loc57_3: i32* = addr_of %.loc57_5
// CHECK:STDOUT:   return
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: fn @AddressOfType() {
// CHECK:STDOUT: !entry:
// CHECK:STDOUT:   %.loc64: type* = addr_of i32
// CHECK:STDOUT:   %.loc68_5: type = const_type i32
// CHECK:STDOUT:   %.loc68_14: type = ptr_type const i32
// CHECK:STDOUT:   %.loc68_3: type* = addr_of %.loc68_14
// CHECK:STDOUT:   return
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: fn @AddressOfTupleElementValue() {
// CHECK:STDOUT: !entry:
// CHECK:STDOUT:   %.loc75_6: i32 = int_literal 1
// CHECK:STDOUT:   %.loc75_9: i32 = int_literal 2
// CHECK:STDOUT:   %.loc75_10.1: (i32, i32) = tuple_literal (%.loc75_6, %.loc75_9)
// CHECK:STDOUT:   %.loc75_12: i32 = int_literal 0
// CHECK:STDOUT:   %.loc75_10.2: (i32, i32) = tuple_value (%.loc75_6, %.loc75_9)
// CHECK:STDOUT:   %.loc75_10.3: (i32, i32) = converted %.loc75_10.1, %.loc75_10.2
// CHECK:STDOUT:   %.loc75_13: i32 = tuple_index %.loc75_10.3, %.loc75_12
// CHECK:STDOUT:   %.loc75_3: i32* = addr_of %.loc75_13
// CHECK:STDOUT:   return
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: fn @AddressOfParam(%param: i32) {
// CHECK:STDOUT: !entry:
// CHECK:STDOUT:   %.loc82_22: type = ptr_type i32
// CHECK:STDOUT:   %param_addr.var: ref i32* = var param_addr
// CHECK:STDOUT:   %param_addr: ref i32* = bind_name param_addr, %param_addr.var
// CHECK:STDOUT:   %param.ref: i32 = name_ref param, %param
// CHECK:STDOUT:   %.loc82_26: i32* = addr_of %param.ref
// CHECK:STDOUT:   assign %param_addr.var, %.loc82_26
// CHECK:STDOUT:   return
// CHECK:STDOUT: }
// CHECK:STDOUT:
