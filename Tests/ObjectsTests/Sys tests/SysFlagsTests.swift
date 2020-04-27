import Foundation
import XCTest
import VioletCompiler
@testable import VioletObjects

class SysFlagsTests: XCTestCase {

  // MARK: - Warnings

  func test_warnings() {
    var args = Arguments()
    var env = Environment(from: [:])

    args.ignoreEnvironment = false
    args.warnings = [.always, .default, .error]
    env.warnings = [.ignore, .module, .once]

    let flags = SysFlags(arguments: args, environment: env)

    XCTAssertEqual(flags.warnings, [
      .ignore, .module, .once, .always, .default, .error
    ])
  }

  func test_warnings_ignoreEnv() {
    var args = Arguments()
    var env = Environment(from: [:])

    args.ignoreEnvironment = true
    args.warnings = [.always, .default, .error]
    env.warnings = [.ignore, .module, .once]

    let flags = SysFlags(arguments: args, environment: env)

    XCTAssertEqual(flags.warnings, [
      .always, .default, .error
    ])
  }

  func test_bytesWarning() {
    let presets: [BytesWarningOption] = [.ignore, .warning, .error]

    for value in presets {
      var args = Arguments()
      let env = Environment(from: [:])

      args.bytesWarning = value

      let flags = SysFlags(arguments: args, environment: env)
      XCTAssertEqual(flags.bytesWarning, value)
    }
  }

  // MARK: - Optimizations

  func test_optimizations_arg_setToNone_alwaysUsesEnv() {
    let presets: [OptimizationLevel] = [.none, .O, .OO]

    for value in presets {
      var args = Arguments()
      var env = Environment(from: [:])

      args.ignoreEnvironment = false
      args.optimize = .none
      env.optimize = value

      let flags = SysFlags(arguments: args, environment: env)
      XCTAssertEqual(flags.optimize, value)
    }
  }

  func test_optimizations_arg_setToO_withEnv_setToNone_orO_isAlwaysOO() {
    let presets: [OptimizationLevel] = [.none, .O]

    for value in presets {
      var args = Arguments()
      var env = Environment(from: [:])

      args.ignoreEnvironment = false
      args.optimize = .O
      env.optimize = value

      let flags = SysFlags(arguments: args, environment: env)
      XCTAssertEqual(flags.optimize, .O)
    }
  }

  func test_optimizations_arg_setToO_withEnv_setToOO_isOO() {
    var args = Arguments()
    var env = Environment(from: [:])

    args.ignoreEnvironment = false
    args.optimize = .O
    env.optimize = .OO

    let flags = SysFlags(arguments: args, environment: env)
    XCTAssertEqual(flags.optimize, .OO)
  }

  func test_optimizations_arg_setToOO_isAlwaysOO() {
    let presets: [OptimizationLevel] = [.none, .O, .OO]

    for value in presets {
      var args = Arguments()
      var env = Environment(from: [:])

      args.ignoreEnvironment = false
      args.optimize = .OO
      env.optimize = value

      let flags = SysFlags(arguments: args, environment: env)
      XCTAssertEqual(flags.optimize, .OO)
    }
  }

  func test_optimizations_ignoreEnv() {
    let presets: [OptimizationLevel] = [.none, .O, .OO]

    for value in presets {
      var args = Arguments()
      let env = Environment(from: [:])

      args.ignoreEnvironment = true
      args.optimize = value

      let flags = SysFlags(arguments: args, environment: env)
      XCTAssertEqual(flags.optimize, value)
    }
  }

  // MARK: - Flags

  func test_inspectInteractively() {
    var args = Arguments()
    let env = Environment(from: [:])

    args.inspectInteractively = true

    let flags = SysFlags(arguments: args, environment: env)
    XCTAssertEqual(flags.inspect, true)
  }

  func test_ignoreEnvironment() {
    var args = Arguments()
    let env = Environment(from: [:])

    args.ignoreEnvironment = true
    let flags = SysFlags(arguments: args, environment: env)

    XCTAssertEqual(flags.ignoreEnvironment, true)
  }

  func test_isolated() {
    var args = Arguments()
    let env = Environment(from: [:])

    args.isolated = true
    let flags = SysFlags(arguments: args, environment: env)

    XCTAssertEqual(flags.isolated, true)
  }
}
