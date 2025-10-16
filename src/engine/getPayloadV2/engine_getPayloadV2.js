/**
 * @fileoverview engine_getPayloadV2 JSON-RPC method
 */

/**
 * @typedef {import('../../types/index.js').Address} Address
 * @typedef {import('../../types/index.js').Hash} Hash
 * @typedef {import('../../types/index.js').Quantity} Quantity
 * @typedef {import('../../types/index.js').BlockTag} BlockTag
 * @typedef {import('../../types/index.js').BlockSpec} BlockSpec
 */

/**
 * Obtains execution payload from payload build process
 *
 * @example
 * Payload id: "0x0000000038fa5dd"
 * Result: ...
 *
 * Implements the `engine_getPayloadV2` JSON-RPC method.
 */

/** The JSON-RPC method name */
export const method = 'engine_getPayloadV2'

/**
 * Parameters for `engine_getPayloadV2`
 *
 * @typedef {Object} Params
 * @property {Quantity} payload id - 8 hex encoded bytes
 */

export {}
/**
 * Result for `engine_getPayloadV2`
 *
 * @typedef {Quantity} Result
 */
