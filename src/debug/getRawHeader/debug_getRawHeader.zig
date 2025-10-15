const std = @import("std");
const types = @import("../../types.zig");

/// Returns an RLP-encoded header.
///
/// Example:
/// Block: "0x32026E"
/// Result: "0xf90236a09f73691f6dabca4f0a99b05d0a701995506aa311dcaa9ce9833d6f4ca474c162a01dcc4de8dec75d7aab85b567b6ccd41ad312451b948a7413f0a142fd40d4934794c6e2459991bfe27cca6d86722f35da23a1e4cb97a078103ea8c47231886481d72ec1afae6eeb06c3773ce24a91323d5c9eed69d4cca0008992da2531db404f07b0871dd620a94ba346963e1b1c6dc7b00748e8593a1ea0b6c3890d9604434fc52f722848c84d1770add20cd75bbc28cdedff42940dbb56b90100200800000400000002000e0000000401000000440100000000c0400600000002000801000000040480020840048000000000400000000000000020004220000011002000000000000204000800000010010002000002000000000040a000000000000400020000010885000000000808000000008800001004002010020300005000000010002110410402000000000000000890000008000000000000000000020040000002000000000000810400000040006000004000004080020000000000000022001000000000000840400000000220250000000000080402000420000418000000000000000400040000004080040010200000000000108020020000808332026e8401c9c380833e3c3c846436f93899d883010b05846765746888676f312e32302e32856c696e7578a0112d8f15793e7df7f8dcdb21c891cff78c0d1839cb5b6dcd06116cdbb99536ae88000000000000000008a0cdb97712af6685bb9650d21d609525913293c48adda7c45990926daada335c9b"
///
/// Implements the `debug_getRawHeader` JSON-RPC method.
pub const DebugGetRawHeader = @This();

/// The JSON-RPC method name
pub const method = "debug_getRawHeader";

/// Parameters for `debug_getRawHeader`
pub const Params = struct {
    /// Block number or tag
    block: types.Quantity,

    pub fn jsonStringify(self: Params, jws: anytype) !void {
        try jws.beginArray();
        try jws.write(self.block);
        try jws.endArray();
    }

    pub fn jsonParseFromValue(allocator: std.mem.Allocator, source: std.json.Value, options: std.json.ParseOptions) !Params {
        if (source != .array) return error.UnexpectedToken;
        if (source.array.items.len != 1) return error.InvalidParamCount;

        return Params{
            .block = try std.json.innerParseFromValue(types.Quantity, allocator, source.array.items[0], options),
        };
    }
};

/// Result for `debug_getRawHeader`
pub const Result = struct {
    /// hex encoded bytes
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
