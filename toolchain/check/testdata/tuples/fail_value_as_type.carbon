// Part of the Carbon Language project, under the Apache License v2.0 with LLVM
// Exceptions. See /LICENSE for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
// AUTOUPDATE

// CHECK:STDERR: fail_value_as_type.carbon:[[@LINE+3]]:8: ERROR: Cannot implicitly convert from `i32` to `type`.
// CHECK:STDERR: var x: (1, );
// CHECK:STDERR:        ^~~~~
var x: (1, );

// CHECK:STDOUT: --- fail_value_as_type.carbon
// CHECK:STDOUT:
// CHECK:STDOUT: constants {
// CHECK:STDOUT:   %.loc10_12.1: type = tuple_type (i32)
// CHECK:STDOUT:   %.loc10_12.2: type = tuple_type (<error>)
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: file {
// CHECK:STDOUT:   package: <namespace> = namespace package, {.x = %x}
// CHECK:STDOUT:   %.loc10_9: i32 = int_literal 1
// CHECK:STDOUT:   %.loc10_12.1: (i32,) = tuple_literal (%.loc10_9)
// CHECK:STDOUT:   %.loc10_12.2: type = converted %.loc10_12.1, constants.%.loc10_12.2
// CHECK:STDOUT:   %x.var: ref (<error>,) = var x
// CHECK:STDOUT:   %x: ref (<error>,) = bind_name x, %x.var
// CHECK:STDOUT: }
// CHECK:STDOUT:
