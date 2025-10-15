const std = @import("std");
const types = @import("../../types.zig");

/// Runs execution payload validation
///
/// Example:
/// Execution payload: ...
/// Expected blob versioned hashes: ...
/// Root of the parent beacon block: "0x169630f535b4a41330164c6e5c92b1224c0c407f582d407d0ac3d206cd32fd52"
/// Result: ...
///
/// Implements the `engine_newPayloadV3` JSON-RPC method.
pub const EngineNewPayloadV3 = @This();

/// The JSON-RPC method name
pub const method = "engine_newPayloadV3";

/// Parameters for `engine_newPayloadV3`
pub const Params = struct {
    /// Execution payload object V3
    execution payload: types.Quantity,
    expected blob versioned hashes: types.Quantity,
    /// 32 byte hex value
    root of the parent beacon block: types.Hash,

    pub fn jsonStringify(self: Params, jws: anytype) !void {
        try jws.beginArray();
        try jws.write(self.execution payload);
        try jws.write(self.expected blob versioned hashes);
        try jws.write(self.root of the parent beacon block);
        try jws.endArray();
    }

    pub fn jsonParseFromValue(allocator: std.mem.Allocator, source: std.json.Value, options: std.json.ParseOptions) !Params {
        if (source != .array) return error.UnexpectedToken;
        if (source.array.items.len != 3) return error.InvalidParamCount;

        return Params{
            .execution payload = try std.json.innerParseFromValue(types.Quantity, allocator, source.array.items[0], options),
            .expected blob versioned hashes = try std.json.innerParseFromValue(types.Quantity, allocator, source.array.items[1], options),
            .root of the parent beacon block = try std.json.innerParseFromValue(types.Hash, allocator, source.array.items[2], options),
        };
    }
};

/// Result for `engine_newPayloadV3`
pub const Result = struct {
    /// Payload status object deprecating INVALID_BLOCK_HASH status
    value: types.Quantity,

    pub fn jsonStringify(self: Result, jws: anytype) !void {
        try jws.write(self.value);
    }

    pub fn jsonParseFromValue(allocator: std.mem.Allocator, source: std.json.Value, options: std.json.ParseOptions) !Result {
        return Result{
            .value = try std.json.innerParseFromValue(types.Quantity, allocator, source, options),
        };
    }
};
