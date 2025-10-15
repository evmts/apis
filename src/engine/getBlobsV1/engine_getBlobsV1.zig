const std = @import("std");
const types = @import("../../types.zig");

/// Fetches blobs from the blob pool
///
/// Example:
/// Blob versioned hashes: ...
/// Result: ...
///
/// Implements the `engine_getBlobsV1` JSON-RPC method.
pub const EngineGetBlobsV1 = @This();

/// The JSON-RPC method name
pub const method = "engine_getBlobsV1";

/// Parameters for `engine_getBlobsV1`
pub const Params = struct {
    blob versioned hashes: types.Quantity,

    pub fn jsonStringify(self: Params, jws: anytype) !void {
        try jws.beginArray();
        try jws.write(self.blob versioned hashes);
        try jws.endArray();
    }

    pub fn jsonParseFromValue(allocator: std.mem.Allocator, source: std.json.Value, options: std.json.ParseOptions) !Params {
        if (source != .array) return error.UnexpectedToken;
        if (source.array.items.len != 1) return error.InvalidParamCount;

        return Params{
            .blob versioned hashes = try std.json.innerParseFromValue(types.Quantity, allocator, source.array.items[0], options),
        };
    }
};

/// Result for `engine_getBlobsV1`
pub const Result = struct {
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
