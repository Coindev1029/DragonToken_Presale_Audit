// SPDX-License-Identifier: MIT

// File: @openzeppelin/contracts/utils/Nonces.sol


// OpenZeppelin Contracts (last updated v5.0.0) (utils/Nonces.sol)

/**
 * @dev Provides tracking nonces for addresses. Nonces will only increment.
 */
abstract contract Nonces {
    /**
     * @dev The nonce used for an `account` is not the expected current nonce.
     */
    error InvalidAccountNonce(address account, uint256 currentNonce);

    mapping(address account => uint256) private _nonces;

    /**
     * @dev Returns the next unused nonce for an address.
     */
    function nonces(address owner) public view virtual returns (uint256) {
        return _nonces[owner];
    }

    /**
     * @dev Consumes a nonce.
     *
     * Returns the current value and increments nonce.
     */
    function _useNonce(address owner) internal virtual returns (uint256) {
        // For each account, the nonce has an initial value of 0, can only be incremented by one, and cannot be
        // decremented or reset. This guarantees that the nonce never overflows.
        unchecked {
            // It is important to do x++ and not ++x here.
            return _nonces[owner]++;
        }
    }

    /**
     * @dev Same as {_useNonce} but checking that `nonce` is the next valid for `owner`.
     */
    function _useCheckedNonce(address owner, uint256 nonce) internal virtual {
        uint256 current = _useNonce(owner);
        if (nonce != current) {
            revert InvalidAccountNonce(owner, current);
        }
    }
}

// File: @openzeppelin/contracts/interfaces/IERC5267.sol


// OpenZeppelin Contracts (last updated v5.0.0) (interfaces/IERC5267.sol)


interface IERC5267 {
    /**
     * @dev MAY be emitted to signal that the domain could have changed.
     */
    event EIP712DomainChanged();

    /**
     * @dev returns the fields and values that describe the domain separator used by this contract for EIP-712
     * signature.
     */
    function eip712Domain()
        external
        view
        returns (
            bytes1 fields,
            string memory name,
            string memory version,
            uint256 chainId,
            address verifyingContract,
            bytes32 salt,
            uint256[] memory extensions
        );
}

// File: @openzeppelin/contracts/utils/StorageSlot.sol


// OpenZeppelin Contracts (last updated v5.0.0) (utils/StorageSlot.sol)
// This file was procedurally generated from scripts/generate/templates/StorageSlot.js.


/**
 * @dev Library for reading and writing primitive types to specific storage slots.
 *
 * Storage slots are often used to avoid storage conflict when dealing with upgradeable contracts.
 * This library helps with reading and writing to such slots without the need for inline assembly.
 *
 * The functions in this library return Slot structs that contain a `value` member that can be used to read or write.
 *
 * Example usage to set ERC1967 implementation slot:
 * ```solidity
 * contract ERC1967 {
 *     bytes32 internal constant _IMPLEMENTATION_SLOT = 0x360894a13ba1a3210667c828492db98dca3e2076cc3735a920a3ca505d382bbc;
 *
 *     function _getImplementation() internal view returns (address) {
 *         return StorageSlot.getAddressSlot(_IMPLEMENTATION_SLOT).value;
 *     }
 *
 *     function _setImplementation(address newImplementation) internal {
 *         require(newImplementation.code.length > 0);
 *         StorageSlot.getAddressSlot(_IMPLEMENTATION_SLOT).value = newImplementation;
 *     }
 * }
 * ```
 */
library StorageSlot {
    struct AddressSlot {
        address value;
    }

    struct BooleanSlot {
        bool value;
    }

    struct Bytes32Slot {
        bytes32 value;
    }

    struct Uint256Slot {
        uint256 value;
    }

    struct StringSlot {
        string value;
    }

    struct BytesSlot {
        bytes value;
    }

    /**
     * @dev Returns an `AddressSlot` with member `value` located at `slot`.
     */
    function getAddressSlot(bytes32 slot) internal pure returns (AddressSlot storage r) {
        /// @solidity memory-safe-assembly
        assembly {
            r.slot := slot
        }
    }

    /**
     * @dev Returns an `BooleanSlot` with member `value` located at `slot`.
     */
    function getBooleanSlot(bytes32 slot) internal pure returns (BooleanSlot storage r) {
        /// @solidity memory-safe-assembly
        assembly {
            r.slot := slot
        }
    }

    /**
     * @dev Returns an `Bytes32Slot` with member `value` located at `slot`.
     */
    function getBytes32Slot(bytes32 slot) internal pure returns (Bytes32Slot storage r) {
        /// @solidity memory-safe-assembly
        assembly {
            r.slot := slot
        }
    }

    /**
     * @dev Returns an `Uint256Slot` with member `value` located at `slot`.
     */
    function getUint256Slot(bytes32 slot) internal pure returns (Uint256Slot storage r) {
        /// @solidity memory-safe-assembly
        assembly {
            r.slot := slot
        }
    }

    /**
     * @dev Returns an `StringSlot` with member `value` located at `slot`.
     */
    function getStringSlot(bytes32 slot) internal pure returns (StringSlot storage r) {
        /// @solidity memory-safe-assembly
        assembly {
            r.slot := slot
        }
    }

    /**
     * @dev Returns an `StringSlot` representation of the string storage pointer `store`.
     */
    function getStringSlot(string storage store) internal pure returns (StringSlot storage r) {
        /// @solidity memory-safe-assembly
        assembly {
            r.slot := store.slot
        }
    }

    /**
     * @dev Returns an `BytesSlot` with member `value` located at `slot`.
     */
    function getBytesSlot(bytes32 slot) internal pure returns (BytesSlot storage r) {
        /// @solidity memory-safe-assembly
        assembly {
            r.slot := slot
        }
    }

    /**
     * @dev Returns an `BytesSlot` representation of the bytes storage pointer `store`.
     */
    function getBytesSlot(bytes storage store) internal pure returns (BytesSlot storage r) {
        /// @solidity memory-safe-assembly
        assembly {
            r.slot := store.slot
        }
    }
}

// File: @openzeppelin/contracts/utils/ShortStrings.sol


// OpenZeppelin Contracts (last updated v5.0.0) (utils/ShortStrings.sol)



// | string  | 0xAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA   |
// | length  | 0x                                                              BB |
type ShortString is bytes32;

/**
 * @dev This library provides functions to convert short memory strings
 * into a `ShortString` type that can be used as an immutable variable.
 *
 * Strings of arbitrary length can be optimized using this library if
 * they are short enough (up to 31 bytes) by packing them with their
 * length (1 byte) in a single EVM word (32 bytes). Additionally, a
 * fallback mechanism can be used for every other case.
 *
 * Usage example:
 *
 * ```solidity
 * contract Named {
 *     using ShortStrings for *;
 *
 *     ShortString private immutable _name;
 *     string private _nameFallback;
 *
 *     constructor(string memory contractName) {
 *         _name = contractName.toShortStringWithFallback(_nameFallback);
 *     }
 *
 *     function name() external view returns (string memory) {
 *         return _name.toStringWithFallback(_nameFallback);
 *     }
 * }
 * ```
 */
library ShortStrings {
    // Used as an identifier for strings longer than 31 bytes.
    bytes32 private constant FALLBACK_SENTINEL = 0x00000000000000000000000000000000000000000000000000000000000000FF;

    error StringTooLong(string str);
    error InvalidShortString();

    /**
     * @dev Encode a string of at most 31 chars into a `ShortString`.
     *
     * This will trigger a `StringTooLong` error is the input string is too long.
     */
    function toShortString(string memory str) internal pure returns (ShortString) {
        bytes memory bstr = bytes(str);
        if (bstr.length > 31) {
            revert StringTooLong(str);
        }
        return ShortString.wrap(bytes32(uint256(bytes32(bstr)) | bstr.length));
    }

    /**
     * @dev Decode a `ShortString` back to a "normal" string.
     */
    function toString(ShortString sstr) internal pure returns (string memory) {
        uint256 len = byteLength(sstr);
        // using `new string(len)` would work locally but is not memory safe.
        string memory str = new string(32);
        /// @solidity memory-safe-assembly
        assembly {
            mstore(str, len)
            mstore(add(str, 0x20), sstr)
        }
        return str;
    }

    /**
     * @dev Return the length of a `ShortString`.
     */
    function byteLength(ShortString sstr) internal pure returns (uint256) {
        uint256 result = uint256(ShortString.unwrap(sstr)) & 0xFF;
        if (result > 31) {
            revert InvalidShortString();
        }
        return result;
    }

    /**
     * @dev Encode a string into a `ShortString`, or write it to storage if it is too long.
     */
    function toShortStringWithFallback(string memory value, string storage store) internal returns (ShortString) {
        if (bytes(value).length < 32) {
            return toShortString(value);
        } else {
            StorageSlot.getStringSlot(store).value = value;
            return ShortString.wrap(FALLBACK_SENTINEL);
        }
    }

    /**
     * @dev Decode a string that was encoded to `ShortString` or written to storage using {setWithFallback}.
     */
    function toStringWithFallback(ShortString value, string storage store) internal pure returns (string memory) {
        if (ShortString.unwrap(value) != FALLBACK_SENTINEL) {
            return toString(value);
        } else {
            return store;
        }
    }

    /**
     * @dev Return the length of a string that was encoded to `ShortString` or written to storage using
     * {setWithFallback}.
     *
     * WARNING: This will return the "byte length" of the string. This may not reflect the actual length in terms of
     * actual characters as the UTF-8 encoding of a single character can span over multiple bytes.
     */
    function byteLengthWithFallback(ShortString value, string storage store) internal view returns (uint256) {
        if (ShortString.unwrap(value) != FALLBACK_SENTINEL) {
            return byteLength(value);
        } else {
            return bytes(store).length;
        }
    }
}

// File: @openzeppelin/contracts/utils/math/SignedMath.sol


// OpenZeppelin Contracts (last updated v5.0.0) (utils/math/SignedMath.sol)


/**
 * @dev Standard signed math utilities missing in the Solidity language.
 */
library SignedMath {
    /**
     * @dev Returns the largest of two signed numbers.
     */
    function max(int256 a, int256 b) internal pure returns (int256) {
        return a > b ? a : b;
    }

    /**
     * @dev Returns the smallest of two signed numbers.
     */
    function min(int256 a, int256 b) internal pure returns (int256) {
        return a < b ? a : b;
    }

    /**
     * @dev Returns the average of two signed numbers without overflow.
     * The result is rounded towards zero.
     */
    function average(int256 a, int256 b) internal pure returns (int256) {
        // Formula from the book "Hacker's Delight"
        int256 x = (a & b) + ((a ^ b) >> 1);
        return x + (int256(uint256(x) >> 255) & (a ^ b));
    }

    /**
     * @dev Returns the absolute unsigned value of a signed value.
     */
    function abs(int256 n) internal pure returns (uint256) {
        unchecked {
            // must be unchecked in order to support `n = type(int256).min`
            return uint256(n >= 0 ? n : -n);
        }
    }
}

// File: @openzeppelin/contracts/utils/math/Math.sol


// OpenZeppelin Contracts (last updated v5.0.0) (utils/math/Math.sol)


/**
 * @dev Standard math utilities missing in the Solidity language.
 */
library Math {
    /**
     * @dev Muldiv operation overflow.
     */
    error MathOverflowedMulDiv();

    enum Rounding {
        Floor, // Toward negative infinity
        Ceil, // Toward positive infinity
        Trunc, // Toward zero
        Expand // Away from zero
    }

    /**
     * @dev Returns the addition of two unsigned integers, with an overflow flag.
     */
    function tryAdd(uint256 a, uint256 b) internal pure returns (bool, uint256) {
        unchecked {
            uint256 c = a + b;
            if (c < a) return (false, 0);
            return (true, c);
        }
    }

    /**
     * @dev Returns the subtraction of two unsigned integers, with an overflow flag.
     */
    function trySub(uint256 a, uint256 b) internal pure returns (bool, uint256) {
        unchecked {
            if (b > a) return (false, 0);
            return (true, a - b);
        }
    }

    /**
     * @dev Returns the multiplication of two unsigned integers, with an overflow flag.
     */
    function tryMul(uint256 a, uint256 b) internal pure returns (bool, uint256) {
        unchecked {
            // Gas optimization: this is cheaper than requiring 'a' not being zero, but the
            // benefit is lost if 'b' is also tested.
            // See: https://github.com/OpenZeppelin/openzeppelin-contracts/pull/522
            if (a == 0) return (true, 0);
            uint256 c = a * b;
            if (c / a != b) return (false, 0);
            return (true, c);
        }
    }

    /**
     * @dev Returns the division of two unsigned integers, with a division by zero flag.
     */
    function tryDiv(uint256 a, uint256 b) internal pure returns (bool, uint256) {
        unchecked {
            if (b == 0) return (false, 0);
            return (true, a / b);
        }
    }

    /**
     * @dev Returns the remainder of dividing two unsigned integers, with a division by zero flag.
     */
    function tryMod(uint256 a, uint256 b) internal pure returns (bool, uint256) {
        unchecked {
            if (b == 0) return (false, 0);
            return (true, a % b);
        }
    }

    /**
     * @dev Returns the largest of two numbers.
     */
    function max(uint256 a, uint256 b) internal pure returns (uint256) {
        return a > b ? a : b;
    }

    /**
     * @dev Returns the smallest of two numbers.
     */
    function min(uint256 a, uint256 b) internal pure returns (uint256) {
        return a < b ? a : b;
    }

    /**
     * @dev Returns the average of two numbers. The result is rounded towards
     * zero.
     */
    function average(uint256 a, uint256 b) internal pure returns (uint256) {
        // (a + b) / 2 can overflow.
        return (a & b) + (a ^ b) / 2;
    }

    /**
     * @dev Returns the ceiling of the division of two numbers.
     *
     * This differs from standard division with `/` in that it rounds towards infinity instead
     * of rounding towards zero.
     */
    function ceilDiv(uint256 a, uint256 b) internal pure returns (uint256) {
        if (b == 0) {
            // Guarantee the same behavior as in a regular Solidity division.
            return a / b;
        }

        // (a + b - 1) / b can overflow on addition, so we distribute.
        return a == 0 ? 0 : (a - 1) / b + 1;
    }

    /**
     * @notice Calculates floor(x * y / denominator) with full precision. Throws if result overflows a uint256 or
     * denominator == 0.
     * @dev Original credit to Remco Bloemen under MIT license (https://xn--2-umb.com/21/muldiv) with further edits by
     * Uniswap Labs also under MIT license.
     */
    function mulDiv(uint256 x, uint256 y, uint256 denominator) internal pure returns (uint256 result) {
        unchecked {
            // 512-bit multiply [prod1 prod0] = x * y. Compute the product mod 2^256 and mod 2^256 - 1, then use
            // use the Chinese Remainder Theorem to reconstruct the 512 bit result. The result is stored in two 256
            // variables such that product = prod1 * 2^256 + prod0.
            uint256 prod0 = x * y; // Least significant 256 bits of the product
            uint256 prod1; // Most significant 256 bits of the product
            assembly {
                let mm := mulmod(x, y, not(0))
                prod1 := sub(sub(mm, prod0), lt(mm, prod0))
            }

            // Handle non-overflow cases, 256 by 256 division.
            if (prod1 == 0) {
                // Solidity will revert if denominator == 0, unlike the div opcode on its own.
                // The surrounding unchecked block does not change this fact.
                // See https://docs.soliditylang.org/en/latest/control-structures.html#checked-or-unchecked-arithmetic.
                return prod0 / denominator;
            }

            // Make sure the result is less than 2^256. Also prevents denominator == 0.
            if (denominator <= prod1) {
                revert MathOverflowedMulDiv();
            }

            ///////////////////////////////////////////////
            // 512 by 256 division.
            ///////////////////////////////////////////////

            // Make division exact by subtracting the remainder from [prod1 prod0].
            uint256 remainder;
            assembly {
                // Compute remainder using mulmod.
                remainder := mulmod(x, y, denominator)

                // Subtract 256 bit number from 512 bit number.
                prod1 := sub(prod1, gt(remainder, prod0))
                prod0 := sub(prod0, remainder)
            }

            // Factor powers of two out of denominator and compute largest power of two divisor of denominator.
            // Always >= 1. See https://cs.stackexchange.com/q/138556/92363.

            uint256 twos = denominator & (0 - denominator);
            assembly {
                // Divide denominator by twos.
                denominator := div(denominator, twos)

                // Divide [prod1 prod0] by twos.
                prod0 := div(prod0, twos)

                // Flip twos such that it is 2^256 / twos. If twos is zero, then it becomes one.
                twos := add(div(sub(0, twos), twos), 1)
            }

            // Shift in bits from prod1 into prod0.
            prod0 |= prod1 * twos;

            // Invert denominator mod 2^256. Now that denominator is an odd number, it has an inverse modulo 2^256 such
            // that denominator * inv = 1 mod 2^256. Compute the inverse by starting with a seed that is correct for
            // four bits. That is, denominator * inv = 1 mod 2^4.
            uint256 inverse = (3 * denominator) ^ 2;

            // Use the Newton-Raphson iteration to improve the precision. Thanks to Hensel's lifting lemma, this also
            // works in modular arithmetic, doubling the correct bits in each step.
            inverse *= 2 - denominator * inverse; // inverse mod 2^8
            inverse *= 2 - denominator * inverse; // inverse mod 2^16
            inverse *= 2 - denominator * inverse; // inverse mod 2^32
            inverse *= 2 - denominator * inverse; // inverse mod 2^64
            inverse *= 2 - denominator * inverse; // inverse mod 2^128
            inverse *= 2 - denominator * inverse; // inverse mod 2^256

            // Because the division is now exact we can divide by multiplying with the modular inverse of denominator.
            // This will give us the correct result modulo 2^256. Since the preconditions guarantee that the outcome is
            // less than 2^256, this is the final result. We don't need to compute the high bits of the result and prod1
            // is no longer required.
            result = prod0 * inverse;
            return result;
        }
    }

    /**
     * @notice Calculates x * y / denominator with full precision, following the selected rounding direction.
     */
    function mulDiv(uint256 x, uint256 y, uint256 denominator, Rounding rounding) internal pure returns (uint256) {
        uint256 result = mulDiv(x, y, denominator);
        if (unsignedRoundsUp(rounding) && mulmod(x, y, denominator) > 0) {
            result += 1;
        }
        return result;
    }

    /**
     * @dev Returns the square root of a number. If the number is not a perfect square, the value is rounded
     * towards zero.
     *
     * Inspired by Henry S. Warren, Jr.'s "Hacker's Delight" (Chapter 11).
     */
    function sqrt(uint256 a) internal pure returns (uint256) {
        if (a == 0) {
            return 0;
        }

        // For our first guess, we get the biggest power of 2 which is smaller than the square root of the target.
        //
        // We know that the "msb" (most significant bit) of our target number `a` is a power of 2 such that we have
        // `msb(a) <= a < 2*msb(a)`. This value can be written `msb(a)=2**k` with `k=log2(a)`.
        //
        // This can be rewritten `2**log2(a) <= a < 2**(log2(a) + 1)`
        // → `sqrt(2**k) <= sqrt(a) < sqrt(2**(k+1))`
        // → `2**(k/2) <= sqrt(a) < 2**((k+1)/2) <= 2**(k/2 + 1)`
        //
        // Consequently, `2**(log2(a) / 2)` is a good first approximation of `sqrt(a)` with at least 1 correct bit.
        uint256 result = 1 << (log2(a) >> 1);

        // At this point `result` is an estimation with one bit of precision. We know the true value is a uint128,
        // since it is the square root of a uint256. Newton's method converges quadratically (precision doubles at
        // every iteration). We thus need at most 7 iteration to turn our partial result with one bit of precision
        // into the expected uint128 result.
        unchecked {
            result = (result + a / result) >> 1;
            result = (result + a / result) >> 1;
            result = (result + a / result) >> 1;
            result = (result + a / result) >> 1;
            result = (result + a / result) >> 1;
            result = (result + a / result) >> 1;
            result = (result + a / result) >> 1;
            return min(result, a / result);
        }
    }

    /**
     * @notice Calculates sqrt(a), following the selected rounding direction.
     */
    function sqrt(uint256 a, Rounding rounding) internal pure returns (uint256) {
        unchecked {
            uint256 result = sqrt(a);
            return result + (unsignedRoundsUp(rounding) && result * result < a ? 1 : 0);
        }
    }

    /**
     * @dev Return the log in base 2 of a positive value rounded towards zero.
     * Returns 0 if given 0.
     */
    function log2(uint256 value) internal pure returns (uint256) {
        uint256 result = 0;
        unchecked {
            if (value >> 128 > 0) {
                value >>= 128;
                result += 128;
            }
            if (value >> 64 > 0) {
                value >>= 64;
                result += 64;
            }
            if (value >> 32 > 0) {
                value >>= 32;
                result += 32;
            }
            if (value >> 16 > 0) {
                value >>= 16;
                result += 16;
            }
            if (value >> 8 > 0) {
                value >>= 8;
                result += 8;
            }
            if (value >> 4 > 0) {
                value >>= 4;
                result += 4;
            }
            if (value >> 2 > 0) {
                value >>= 2;
                result += 2;
            }
            if (value >> 1 > 0) {
                result += 1;
            }
        }
        return result;
    }

    /**
     * @dev Return the log in base 2, following the selected rounding direction, of a positive value.
     * Returns 0 if given 0.
     */
    function log2(uint256 value, Rounding rounding) internal pure returns (uint256) {
        unchecked {
            uint256 result = log2(value);
            return result + (unsignedRoundsUp(rounding) && 1 << result < value ? 1 : 0);
        }
    }

    /**
     * @dev Return the log in base 10 of a positive value rounded towards zero.
     * Returns 0 if given 0.
     */
    function log10(uint256 value) internal pure returns (uint256) {
        uint256 result = 0;
        unchecked {
            if (value >= 10 ** 64) {
                value /= 10 ** 64;
                result += 64;
            }
            if (value >= 10 ** 32) {
                value /= 10 ** 32;
                result += 32;
            }
            if (value >= 10 ** 16) {
                value /= 10 ** 16;
                result += 16;
            }
            if (value >= 10 ** 8) {
                value /= 10 ** 8;
                result += 8;
            }
            if (value >= 10 ** 4) {
                value /= 10 ** 4;
                result += 4;
            }
            if (value >= 10 ** 2) {
                value /= 10 ** 2;
                result += 2;
            }
            if (value >= 10 ** 1) {
                result += 1;
            }
        }
        return result;
    }

    /**
     * @dev Return the log in base 10, following the selected rounding direction, of a positive value.
     * Returns 0 if given 0.
     */
    function log10(uint256 value, Rounding rounding) internal pure returns (uint256) {
        unchecked {
            uint256 result = log10(value);
            return result + (unsignedRoundsUp(rounding) && 10 ** result < value ? 1 : 0);
        }
    }

    /**
     * @dev Return the log in base 256 of a positive value rounded towards zero.
     * Returns 0 if given 0.
     *
     * Adding one to the result gives the number of pairs of hex symbols needed to represent `value` as a hex string.
     */
    function log256(uint256 value) internal pure returns (uint256) {
        uint256 result = 0;
        unchecked {
            if (value >> 128 > 0) {
                value >>= 128;
                result += 16;
            }
            if (value >> 64 > 0) {
                value >>= 64;
                result += 8;
            }
            if (value >> 32 > 0) {
                value >>= 32;
                result += 4;
            }
            if (value >> 16 > 0) {
                value >>= 16;
                result += 2;
            }
            if (value >> 8 > 0) {
                result += 1;
            }
        }
        return result;
    }

    /**
     * @dev Return the log in base 256, following the selected rounding direction, of a positive value.
     * Returns 0 if given 0.
     */
    function log256(uint256 value, Rounding rounding) internal pure returns (uint256) {
        unchecked {
            uint256 result = log256(value);
            return result + (unsignedRoundsUp(rounding) && 1 << (result << 3) < value ? 1 : 0);
        }
    }

    /**
     * @dev Returns whether a provided rounding mode is considered rounding up for unsigned integers.
     */
    function unsignedRoundsUp(Rounding rounding) internal pure returns (bool) {
        return uint8(rounding) % 2 == 1;
    }
}

// File: @openzeppelin/contracts/utils/Strings.sol


// OpenZeppelin Contracts (last updated v5.0.0) (utils/Strings.sol)




/**
 * @dev String operations.
 */
library Strings {
    bytes16 private constant HEX_DIGITS = "0123456789abcdef";
    uint8 private constant ADDRESS_LENGTH = 20;

    /**
     * @dev The `value` string doesn't fit in the specified `length`.
     */
    error StringsInsufficientHexLength(uint256 value, uint256 length);

    /**
     * @dev Converts a `uint256` to its ASCII `string` decimal representation.
     */
    function toString(uint256 value) internal pure returns (string memory) {
        unchecked {
            uint256 length = Math.log10(value) + 1;
            string memory buffer = new string(length);
            uint256 ptr;
            /// @solidity memory-safe-assembly
            assembly {
                ptr := add(buffer, add(32, length))
            }
            while (true) {
                ptr--;
                /// @solidity memory-safe-assembly
                assembly {
                    mstore8(ptr, byte(mod(value, 10), HEX_DIGITS))
                }
                value /= 10;
                if (value == 0) break;
            }
            return buffer;
        }
    }

    /**
     * @dev Converts a `int256` to its ASCII `string` decimal representation.
     */
    function toStringSigned(int256 value) internal pure returns (string memory) {
        return string.concat(value < 0 ? "-" : "", toString(SignedMath.abs(value)));
    }

    /**
     * @dev Converts a `uint256` to its ASCII `string` hexadecimal representation.
     */
    function toHexString(uint256 value) internal pure returns (string memory) {
        unchecked {
            return toHexString(value, Math.log256(value) + 1);
        }
    }

    /**
     * @dev Converts a `uint256` to its ASCII `string` hexadecimal representation with fixed length.
     */
    function toHexString(uint256 value, uint256 length) internal pure returns (string memory) {
        uint256 localValue = value;
        bytes memory buffer = new bytes(2 * length + 2);
        buffer[0] = "0";
        buffer[1] = "x";
        for (uint256 i = 2 * length + 1; i > 1; --i) {
            buffer[i] = HEX_DIGITS[localValue & 0xf];
            localValue >>= 4;
        }
        if (localValue != 0) {
            revert StringsInsufficientHexLength(value, length);
        }
        return string(buffer);
    }

    /**
     * @dev Converts an `address` with fixed length of 20 bytes to its not checksummed ASCII `string` hexadecimal
     * representation.
     */
    function toHexString(address addr) internal pure returns (string memory) {
        return toHexString(uint256(uint160(addr)), ADDRESS_LENGTH);
    }

    /**
     * @dev Returns true if the two strings are equal.
     */
    function equal(string memory a, string memory b) internal pure returns (bool) {
        return bytes(a).length == bytes(b).length && keccak256(bytes(a)) == keccak256(bytes(b));
    }
}

// File: @openzeppelin/contracts/utils/cryptography/MessageHashUtils.sol


// OpenZeppelin Contracts (last updated v5.0.0) (utils/cryptography/MessageHashUtils.sol)



/**
 * @dev Signature message hash utilities for producing digests to be consumed by {ECDSA} recovery or signing.
 *
 * The library provides methods for generating a hash of a message that conforms to the
 * https://eips.ethereum.org/EIPS/eip-191[EIP 191] and https://eips.ethereum.org/EIPS/eip-712[EIP 712]
 * specifications.
 */
library MessageHashUtils {
    /**
     * @dev Returns the keccak256 digest of an EIP-191 signed data with version
     * `0x45` (`personal_sign` messages).
     *
     * The digest is calculated by prefixing a bytes32 `messageHash` with
     * `"\x19Ethereum Signed Message:\n32"` and hashing the result. It corresponds with the
     * hash signed when using the https://eth.wiki/json-rpc/API#eth_sign[`eth_sign`] JSON-RPC method.
     *
     * NOTE: The `messageHash` parameter is intended to be the result of hashing a raw message with
     * keccak256, although any bytes32 value can be safely used because the final digest will
     * be re-hashed.
     *
     * See {ECDSA-recover}.
     */
    function toEthSignedMessageHash(bytes32 messageHash) internal pure returns (bytes32 digest) {
        /// @solidity memory-safe-assembly
        assembly {
            mstore(0x00, "\x19Ethereum Signed Message:\n32") // 32 is the bytes-length of messageHash
            mstore(0x1c, messageHash) // 0x1c (28) is the length of the prefix
            digest := keccak256(0x00, 0x3c) // 0x3c is the length of the prefix (0x1c) + messageHash (0x20)
        }
    }

    /**
     * @dev Returns the keccak256 digest of an EIP-191 signed data with version
     * `0x45` (`personal_sign` messages).
     *
     * The digest is calculated by prefixing an arbitrary `message` with
     * `"\x19Ethereum Signed Message:\n" + len(message)` and hashing the result. It corresponds with the
     * hash signed when using the https://eth.wiki/json-rpc/API#eth_sign[`eth_sign`] JSON-RPC method.
     *
     * See {ECDSA-recover}.
     */
    function toEthSignedMessageHash(bytes memory message) internal pure returns (bytes32) {
        return
            keccak256(bytes.concat("\x19Ethereum Signed Message:\n", bytes(Strings.toString(message.length)), message));
    }

    /**
     * @dev Returns the keccak256 digest of an EIP-191 signed data with version
     * `0x00` (data with intended validator).
     *
     * The digest is calculated by prefixing an arbitrary `data` with `"\x19\x00"` and the intended
     * `validator` address. Then hashing the result.
     *
     * See {ECDSA-recover}.
     */
    function toDataWithIntendedValidatorHash(address validator, bytes memory data) internal pure returns (bytes32) {
        return keccak256(abi.encodePacked(hex"19_00", validator, data));
    }

    /**
     * @dev Returns the keccak256 digest of an EIP-712 typed data (EIP-191 version `0x01`).
     *
     * The digest is calculated from a `domainSeparator` and a `structHash`, by prefixing them with
     * `\x19\x01` and hashing the result. It corresponds to the hash signed by the
     * https://eips.ethereum.org/EIPS/eip-712[`eth_signTypedData`] JSON-RPC method as part of EIP-712.
     *
     * See {ECDSA-recover}.
     */
    function toTypedDataHash(bytes32 domainSeparator, bytes32 structHash) internal pure returns (bytes32 digest) {
        /// @solidity memory-safe-assembly
        assembly {
            let ptr := mload(0x40)
            mstore(ptr, hex"19_01")
            mstore(add(ptr, 0x02), domainSeparator)
            mstore(add(ptr, 0x22), structHash)
            digest := keccak256(ptr, 0x42)
        }
    }
}

// File: @openzeppelin/contracts/utils/cryptography/EIP712.sol


// OpenZeppelin Contracts (last updated v5.0.0) (utils/cryptography/EIP712.sol)





/**
 * @dev https://eips.ethereum.org/EIPS/eip-712[EIP 712] is a standard for hashing and signing of typed structured data.
 *
 * The encoding scheme specified in the EIP requires a domain separator and a hash of the typed structured data, whose
 * encoding is very generic and therefore its implementation in Solidity is not feasible, thus this contract
 * does not implement the encoding itself. Protocols need to implement the type-specific encoding they need in order to
 * produce the hash of their typed data using a combination of `abi.encode` and `keccak256`.
 *
 * This contract implements the EIP 712 domain separator ({_domainSeparatorV4}) that is used as part of the encoding
 * scheme, and the final step of the encoding to obtain the message digest that is then signed via ECDSA
 * ({_hashTypedDataV4}).
 *
 * The implementation of the domain separator was designed to be as efficient as possible while still properly updating
 * the chain id to protect against replay attacks on an eventual fork of the chain.
 *
 * NOTE: This contract implements the version of the encoding known as "v4", as implemented by the JSON RPC method
 * https://docs.metamask.io/guide/signing-data.html[`eth_signTypedDataV4` in MetaMask].
 *
 * NOTE: In the upgradeable version of this contract, the cached values will correspond to the address, and the domain
 * separator of the implementation contract. This will cause the {_domainSeparatorV4} function to always rebuild the
 * separator from the immutable values, which is cheaper than accessing a cached version in cold storage.
 *
 * @custom:oz-upgrades-unsafe-allow state-variable-immutable
 */
abstract contract EIP712 is IERC5267 {
    using ShortStrings for *;

    bytes32 private constant TYPE_HASH =
        keccak256("EIP712Domain(string name,string version,uint256 chainId,address verifyingContract)");

    // Cache the domain separator as an immutable value, but also store the chain id that it corresponds to, in order to
    // invalidate the cached domain separator if the chain id changes.
    bytes32 private immutable _cachedDomainSeparator;
    uint256 private immutable _cachedChainId;
    address private immutable _cachedThis;

    bytes32 private immutable _hashedName;
    bytes32 private immutable _hashedVersion;

    ShortString private immutable _name;
    ShortString private immutable _version;
    string private _nameFallback;
    string private _versionFallback;

    /**
     * @dev Initializes the domain separator and parameter caches.
     *
     * The meaning of `name` and `version` is specified in
     * https://eips.ethereum.org/EIPS/eip-712#definition-of-domainseparator[EIP 712]:
     *
     * - `name`: the user readable name of the signing domain, i.e. the name of the DApp or the protocol.
     * - `version`: the current major version of the signing domain.
     *
     * NOTE: These parameters cannot be changed except through a xref:learn::upgrading-smart-contracts.adoc[smart
     * contract upgrade].
     */
    constructor(string memory name, string memory version) {
        _name = name.toShortStringWithFallback(_nameFallback);
        _version = version.toShortStringWithFallback(_versionFallback);
        _hashedName = keccak256(bytes(name));
        _hashedVersion = keccak256(bytes(version));

        _cachedChainId = block.chainid;
        _cachedDomainSeparator = _buildDomainSeparator();
        _cachedThis = address(this);
    }

    /**
     * @dev Returns the domain separator for the current chain.
     */
    function _domainSeparatorV4() internal view returns (bytes32) {
        if (address(this) == _cachedThis && block.chainid == _cachedChainId) {
            return _cachedDomainSeparator;
        } else {
            return _buildDomainSeparator();
        }
    }

    function _buildDomainSeparator() private view returns (bytes32) {
        return keccak256(abi.encode(TYPE_HASH, _hashedName, _hashedVersion, block.chainid, address(this)));
    }

    /**
     * @dev Given an already https://eips.ethereum.org/EIPS/eip-712#definition-of-hashstruct[hashed struct], this
     * function returns the hash of the fully encoded EIP712 message for this domain.
     *
     * This hash can be used together with {ECDSA-recover} to obtain the signer of a message. For example:
     *
     * ```solidity
     * bytes32 digest = _hashTypedDataV4(keccak256(abi.encode(
     *     keccak256("Mail(address to,string contents)"),
     *     mailTo,
     *     keccak256(bytes(mailContents))
     * )));
     * address signer = ECDSA.recover(digest, signature);
     * ```
     */
    function _hashTypedDataV4(bytes32 structHash) internal view virtual returns (bytes32) {
        return MessageHashUtils.toTypedDataHash(_domainSeparatorV4(), structHash);
    }

    /**
     * @dev See {IERC-5267}.
     */
    function eip712Domain()
        public
        view
        virtual
        returns (
            bytes1 fields,
            string memory name,
            string memory version,
            uint256 chainId,
            address verifyingContract,
            bytes32 salt,
            uint256[] memory extensions
        )
    {
        return (
            hex"0f", // 01111
            _EIP712Name(),
            _EIP712Version(),
            block.chainid,
            address(this),
            bytes32(0),
            new uint256[](0)
        );
    }

    /**
     * @dev The name parameter for the EIP712 domain.
     *
     * NOTE: By default this function reads _name which is an immutable value.
     * It only reads from storage if necessary (in case the value is too large to fit in a ShortString).
     */
    // solhint-disable-next-line func-name-mixedcase
    function _EIP712Name() internal view returns (string memory) {
        return _name.toStringWithFallback(_nameFallback);
    }

    /**
     * @dev The version parameter for the EIP712 domain.
     *
     * NOTE: By default this function reads _version which is an immutable value.
     * It only reads from storage if necessary (in case the value is too large to fit in a ShortString).
     */
    // solhint-disable-next-line func-name-mixedcase
    function _EIP712Version() internal view returns (string memory) {
        return _version.toStringWithFallback(_versionFallback);
    }
}

// File: @openzeppelin/contracts/utils/cryptography/ECDSA.sol


// OpenZeppelin Contracts (last updated v5.0.0) (utils/cryptography/ECDSA.sol)


/**
 * @dev Elliptic Curve Digital Signature Algorithm (ECDSA) operations.
 *
 * These functions can be used to verify that a message was signed by the holder
 * of the private keys of a given address.
 */
library ECDSA {
    enum RecoverError {
        NoError,
        InvalidSignature,
        InvalidSignatureLength,
        InvalidSignatureS
    }

    /**
     * @dev The signature derives the `address(0)`.
     */
    error ECDSAInvalidSignature();

    /**
     * @dev The signature has an invalid length.
     */
    error ECDSAInvalidSignatureLength(uint256 length);

    /**
     * @dev The signature has an S value that is in the upper half order.
     */
    error ECDSAInvalidSignatureS(bytes32 s);

    /**
     * @dev Returns the address that signed a hashed message (`hash`) with `signature` or an error. This will not
     * return address(0) without also returning an error description. Errors are documented using an enum (error type)
     * and a bytes32 providing additional information about the error.
     *
     * If no error is returned, then the address can be used for verification purposes.
     *
     * The `ecrecover` EVM precompile allows for malleable (non-unique) signatures:
     * this function rejects them by requiring the `s` value to be in the lower
     * half order, and the `v` value to be either 27 or 28.
     *
     * IMPORTANT: `hash` _must_ be the result of a hash operation for the
     * verification to be secure: it is possible to craft signatures that
     * recover to arbitrary addresses for non-hashed data. A safe way to ensure
     * this is by receiving a hash of the original message (which may otherwise
     * be too long), and then calling {MessageHashUtils-toEthSignedMessageHash} on it.
     *
     * Documentation for signature generation:
     * - with https://web3js.readthedocs.io/en/v1.3.4/web3-eth-accounts.html#sign[Web3.js]
     * - with https://docs.ethers.io/v5/api/signer/#Signer-signMessage[ethers]
     */
    function tryRecover(bytes32 hash, bytes memory signature) internal pure returns (address, RecoverError, bytes32) {
        if (signature.length == 65) {
            bytes32 r;
            bytes32 s;
            uint8 v;
            // ecrecover takes the signature parameters, and the only way to get them
            // currently is to use assembly.
            /// @solidity memory-safe-assembly
            assembly {
                r := mload(add(signature, 0x20))
                s := mload(add(signature, 0x40))
                v := byte(0, mload(add(signature, 0x60)))
            }
            return tryRecover(hash, v, r, s);
        } else {
            return (address(0), RecoverError.InvalidSignatureLength, bytes32(signature.length));
        }
    }

    /**
     * @dev Returns the address that signed a hashed message (`hash`) with
     * `signature`. This address can then be used for verification purposes.
     *
     * The `ecrecover` EVM precompile allows for malleable (non-unique) signatures:
     * this function rejects them by requiring the `s` value to be in the lower
     * half order, and the `v` value to be either 27 or 28.
     *
     * IMPORTANT: `hash` _must_ be the result of a hash operation for the
     * verification to be secure: it is possible to craft signatures that
     * recover to arbitrary addresses for non-hashed data. A safe way to ensure
     * this is by receiving a hash of the original message (which may otherwise
     * be too long), and then calling {MessageHashUtils-toEthSignedMessageHash} on it.
     */
    function recover(bytes32 hash, bytes memory signature) internal pure returns (address) {
        (address recovered, RecoverError error, bytes32 errorArg) = tryRecover(hash, signature);
        _throwError(error, errorArg);
        return recovered;
    }

    /**
     * @dev Overload of {ECDSA-tryRecover} that receives the `r` and `vs` short-signature fields separately.
     *
     * See https://eips.ethereum.org/EIPS/eip-2098[EIP-2098 short signatures]
     */
    function tryRecover(bytes32 hash, bytes32 r, bytes32 vs) internal pure returns (address, RecoverError, bytes32) {
        unchecked {
            bytes32 s = vs & bytes32(0x7fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff);
            // We do not check for an overflow here since the shift operation results in 0 or 1.
            uint8 v = uint8((uint256(vs) >> 255) + 27);
            return tryRecover(hash, v, r, s);
        }
    }

    /**
     * @dev Overload of {ECDSA-recover} that receives the `r and `vs` short-signature fields separately.
     */
    function recover(bytes32 hash, bytes32 r, bytes32 vs) internal pure returns (address) {
        (address recovered, RecoverError error, bytes32 errorArg) = tryRecover(hash, r, vs);
        _throwError(error, errorArg);
        return recovered;
    }

    /**
     * @dev Overload of {ECDSA-tryRecover} that receives the `v`,
     * `r` and `s` signature fields separately.
     */
    function tryRecover(
        bytes32 hash,
        uint8 v,
        bytes32 r,
        bytes32 s
    ) internal pure returns (address, RecoverError, bytes32) {
        // EIP-2 still allows signature malleability for ecrecover(). Remove this possibility and make the signature
        // unique. Appendix F in the Ethereum Yellow paper (https://ethereum.github.io/yellowpaper/paper.pdf), defines
        // the valid range for s in (301): 0 < s < secp256k1n ÷ 2 + 1, and for v in (302): v ∈ {27, 28}. Most
        // signatures from current libraries generate a unique signature with an s-value in the lower half order.
        //
        // If your library generates malleable signatures, such as s-values in the upper range, calculate a new s-value
        // with 0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEBAAEDCE6AF48A03BBFD25E8CD0364141 - s1 and flip v from 27 to 28 or
        // vice versa. If your library also generates signatures with 0/1 for v instead 27/28, add 27 to v to accept
        // these malleable signatures as well.
        if (uint256(s) > 0x7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF5D576E7357A4501DDFE92F46681B20A0) {
            return (address(0), RecoverError.InvalidSignatureS, s);
        }

        // If the signature is valid (and not malleable), return the signer address
        address signer = ecrecover(hash, v, r, s);
        if (signer == address(0)) {
            return (address(0), RecoverError.InvalidSignature, bytes32(0));
        }

        return (signer, RecoverError.NoError, bytes32(0));
    }

    /**
     * @dev Overload of {ECDSA-recover} that receives the `v`,
     * `r` and `s` signature fields separately.
     */
    function recover(bytes32 hash, uint8 v, bytes32 r, bytes32 s) internal pure returns (address) {
        (address recovered, RecoverError error, bytes32 errorArg) = tryRecover(hash, v, r, s);
        _throwError(error, errorArg);
        return recovered;
    }

    /**
     * @dev Optionally reverts with the corresponding custom error according to the `error` argument provided.
     */
    function _throwError(RecoverError error, bytes32 errorArg) private pure {
        if (error == RecoverError.NoError) {
            return; // no error: do nothing
        } else if (error == RecoverError.InvalidSignature) {
            revert ECDSAInvalidSignature();
        } else if (error == RecoverError.InvalidSignatureLength) {
            revert ECDSAInvalidSignatureLength(uint256(errorArg));
        } else if (error == RecoverError.InvalidSignatureS) {
            revert ECDSAInvalidSignatureS(errorArg);
        }
    }
}

// File: @openzeppelin/contracts/token/ERC20/extensions/IERC20Permit.sol


// OpenZeppelin Contracts (last updated v5.0.0) (token/ERC20/extensions/IERC20Permit.sol)


/**
 * @dev Interface of the ERC20 Permit extension allowing approvals to be made via signatures, as defined in
 * https://eips.ethereum.org/EIPS/eip-2612[EIP-2612].
 *
 * Adds the {permit} method, which can be used to change an account's ERC20 allowance (see {IERC20-allowance}) by
 * presenting a message signed by the account. By not relying on {IERC20-approve}, the token holder account doesn't
 * need to send a transaction, and thus is not required to hold Ether at all.
 *
 * ==== Security Considerations
 *
 * There are two important considerations concerning the use of `permit`. The first is that a valid permit signature
 * expresses an allowance, and it should not be assumed to convey additional meaning. In particular, it should not be
 * considered as an intention to spend the allowance in any specific way. The second is that because permits have
 * built-in replay protection and can be submitted by anyone, they can be frontrun. A protocol that uses permits should
 * take this into consideration and allow a `permit` call to fail. Combining these two aspects, a pattern that may be
 * generally recommended is:
 *
 * ```solidity
 * function doThingWithPermit(..., uint256 value, uint256 deadline, uint8 v, bytes32 r, bytes32 s) public {
 *     try token.permit(msg.sender, address(this), value, deadline, v, r, s) {} catch {}
 *     doThing(..., value);
 * }
 *
 * function doThing(..., uint256 value) public {
 *     token.safeTransferFrom(msg.sender, address(this), value);
 *     ...
 * }
 * ```
 *
 * Observe that: 1) `msg.sender` is used as the owner, leaving no ambiguity as to the signer intent, and 2) the use of
 * `try/catch` allows the permit to fail and makes the code tolerant to frontrunning. (See also
 * {SafeERC20-safeTransferFrom}).
 *
 * Additionally, note that smart contract wallets (such as Argent or Safe) are not able to produce permit signatures, so
 * contracts should have entry points that don't rely on permit.
 */
interface IERC20Permit {
    /**
     * @dev Sets `value` as the allowance of `spender` over ``owner``'s tokens,
     * given ``owner``'s signed approval.
     *
     * IMPORTANT: The same issues {IERC20-approve} has related to transaction
     * ordering also apply here.
     *
     * Emits an {Approval} event.
     *
     * Requirements:
     *
     * - `spender` cannot be the zero address.
     * - `deadline` must be a timestamp in the future.
     * - `v`, `r` and `s` must be a valid `secp256k1` signature from `owner`
     * over the EIP712-formatted function arguments.
     * - the signature must use ``owner``'s current nonce (see {nonces}).
     *
     * For more information on the signature format, see the
     * https://eips.ethereum.org/EIPS/eip-2612#specification[relevant EIP
     * section].
     *
     * CAUTION: See Security Considerations above.
     */
    function permit(
        address owner,
        address spender,
        uint256 value,
        uint256 deadline,
        uint8 v,
        bytes32 r,
        bytes32 s
    ) external;

    /**
     * @dev Returns the current nonce for `owner`. This value must be
     * included whenever a signature is generated for {permit}.
     *
     * Every successful call to {permit} increases ``owner``'s nonce by one. This
     * prevents a signature from being used multiple times.
     */
    function nonces(address owner) external view returns (uint256);

    /**
     * @dev Returns the domain separator used in the encoding of the signature for {permit}, as defined by {EIP712}.
     */
    // solhint-disable-next-line func-name-mixedcase
    function DOMAIN_SEPARATOR() external view returns (bytes32);
}

// File: @openzeppelin/contracts/interfaces/draft-IERC6093.sol


// OpenZeppelin Contracts (last updated v5.0.0) (interfaces/draft-IERC6093.sol)

/**
 * @dev Standard ERC20 Errors
 * Interface of the https://eips.ethereum.org/EIPS/eip-6093[ERC-6093] custom errors for ERC20 tokens.
 */
interface IERC20Errors {
    /**
     * @dev Indicates an error related to the current `balance` of a `sender`. Used in transfers.
     * @param sender Address whose tokens are being transferred.
     * @param balance Current balance for the interacting account.
     * @param needed Minimum amount required to perform a transfer.
     */
    error ERC20InsufficientBalance(address sender, uint256 balance, uint256 needed);

    /**
     * @dev Indicates a failure with the token `sender`. Used in transfers.
     * @param sender Address whose tokens are being transferred.
     */
    error ERC20InvalidSender(address sender);

    /**
     * @dev Indicates a failure with the token `receiver`. Used in transfers.
     * @param receiver Address to which tokens are being transferred.
     */
    error ERC20InvalidReceiver(address receiver);

    /**
     * @dev Indicates a failure with the `spender`’s `allowance`. Used in transfers.
     * @param spender Address that may be allowed to operate on tokens without being their owner.
     * @param allowance Amount of tokens a `spender` is allowed to operate with.
     * @param needed Minimum amount required to perform a transfer.
     */
    error ERC20InsufficientAllowance(address spender, uint256 allowance, uint256 needed);

    /**
     * @dev Indicates a failure with the `approver` of a token to be approved. Used in approvals.
     * @param approver Address initiating an approval operation.
     */
    error ERC20InvalidApprover(address approver);

    /**
     * @dev Indicates a failure with the `spender` to be approved. Used in approvals.
     * @param spender Address that may be allowed to operate on tokens without being their owner.
     */
    error ERC20InvalidSpender(address spender);
}

/**
 * @dev Standard ERC721 Errors
 * Interface of the https://eips.ethereum.org/EIPS/eip-6093[ERC-6093] custom errors for ERC721 tokens.
 */
interface IERC721Errors {
    /**
     * @dev Indicates that an address can't be an owner. For example, `address(0)` is a forbidden owner in EIP-20.
     * Used in balance queries.
     * @param owner Address of the current owner of a token.
     */
    error ERC721InvalidOwner(address owner);

    /**
     * @dev Indicates a `tokenId` whose `owner` is the zero address.
     * @param tokenId Identifier number of a token.
     */
    error ERC721NonexistentToken(uint256 tokenId);

    /**
     * @dev Indicates an error related to the ownership over a particular token. Used in transfers.
     * @param sender Address whose tokens are being transferred.
     * @param tokenId Identifier number of a token.
     * @param owner Address of the current owner of a token.
     */
    error ERC721IncorrectOwner(address sender, uint256 tokenId, address owner);

    /**
     * @dev Indicates a failure with the token `sender`. Used in transfers.
     * @param sender Address whose tokens are being transferred.
     */
    error ERC721InvalidSender(address sender);

    /**
     * @dev Indicates a failure with the token `receiver`. Used in transfers.
     * @param receiver Address to which tokens are being transferred.
     */
    error ERC721InvalidReceiver(address receiver);

    /**
     * @dev Indicates a failure with the `operator`’s approval. Used in transfers.
     * @param operator Address that may be allowed to operate on tokens without being their owner.
     * @param tokenId Identifier number of a token.
     */
    error ERC721InsufficientApproval(address operator, uint256 tokenId);

    /**
     * @dev Indicates a failure with the `approver` of a token to be approved. Used in approvals.
     * @param approver Address initiating an approval operation.
     */
    error ERC721InvalidApprover(address approver);

    /**
     * @dev Indicates a failure with the `operator` to be approved. Used in approvals.
     * @param operator Address that may be allowed to operate on tokens without being their owner.
     */
    error ERC721InvalidOperator(address operator);
}

/**
 * @dev Standard ERC1155 Errors
 * Interface of the https://eips.ethereum.org/EIPS/eip-6093[ERC-6093] custom errors for ERC1155 tokens.
 */
interface IERC1155Errors {
    /**
     * @dev Indicates an error related to the current `balance` of a `sender`. Used in transfers.
     * @param sender Address whose tokens are being transferred.
     * @param balance Current balance for the interacting account.
     * @param needed Minimum amount required to perform a transfer.
     * @param tokenId Identifier number of a token.
     */
    error ERC1155InsufficientBalance(address sender, uint256 balance, uint256 needed, uint256 tokenId);

    /**
     * @dev Indicates a failure with the token `sender`. Used in transfers.
     * @param sender Address whose tokens are being transferred.
     */
    error ERC1155InvalidSender(address sender);

    /**
     * @dev Indicates a failure with the token `receiver`. Used in transfers.
     * @param receiver Address to which tokens are being transferred.
     */
    error ERC1155InvalidReceiver(address receiver);

    /**
     * @dev Indicates a failure with the `operator`’s approval. Used in transfers.
     * @param operator Address that may be allowed to operate on tokens without being their owner.
     * @param owner Address of the current owner of a token.
     */
    error ERC1155MissingApprovalForAll(address operator, address owner);

    /**
     * @dev Indicates a failure with the `approver` of a token to be approved. Used in approvals.
     * @param approver Address initiating an approval operation.
     */
    error ERC1155InvalidApprover(address approver);

    /**
     * @dev Indicates a failure with the `operator` to be approved. Used in approvals.
     * @param operator Address that may be allowed to operate on tokens without being their owner.
     */
    error ERC1155InvalidOperator(address operator);

    /**
     * @dev Indicates an array length mismatch between ids and values in a safeBatchTransferFrom operation.
     * Used in batch transfers.
     * @param idsLength Length of the array of token identifiers
     * @param valuesLength Length of the array of token amounts
     */
    error ERC1155InvalidArrayLength(uint256 idsLength, uint256 valuesLength);
}

// File: @openzeppelin/contracts/utils/Context.sol


// OpenZeppelin Contracts (last updated v5.0.1) (utils/Context.sol)


/**
 * @dev Provides information about the current execution context, including the
 * sender of the transaction and its data. While these are generally available
 * via msg.sender and msg.data, they should not be accessed in such a direct
 * manner, since when dealing with meta-transactions the account sending and
 * paying for execution may not be the actual sender (as far as an application
 * is concerned).
 *
 * This contract is only required for intermediate, library-like contracts.
 */
abstract contract Context {
    function _msgSender() internal view virtual returns (address) {
        return msg.sender;
    }

    function _msgData() internal view virtual returns (bytes calldata) {
        return msg.data;
    }

    function _contextSuffixLength() internal view virtual returns (uint256) {
        return 0;
    }
}

// File: @openzeppelin/contracts/access/Ownable.sol


// OpenZeppelin Contracts (last updated v5.0.0) (access/Ownable.sol)



/**
 * @dev Contract module which provides a basic access control mechanism, where
 * there is an account (an owner) that can be granted exclusive access to
 * specific functions.
 *
 * The initial owner is set to the address provided by the deployer. This can
 * later be changed with {transferOwnership}.
 *
 * This module is used through inheritance. It will make available the modifier
 * `onlyOwner`, which can be applied to your functions to restrict their use to
 * the owner.
 */
abstract contract Ownable is Context {
    address private _owner;

    /**
     * @dev The caller account is not authorized to perform an operation.
     */
    error OwnableUnauthorizedAccount(address account);

    /**
     * @dev The owner is not a valid owner account. (eg. `address(0)`)
     */
    error OwnableInvalidOwner(address owner);

    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

    /**
     * @dev Initializes the contract setting the address provided by the deployer as the initial owner.
     */
    constructor(address initialOwner) {
        if (initialOwner == address(0)) {
            revert OwnableInvalidOwner(address(0));
        }
        _transferOwnership(initialOwner);
    }

    /**
     * @dev Throws if called by any account other than the owner.
     */
    modifier onlyOwner() {
        _checkOwner();
        _;
    }

    /**
     * @dev Returns the address of the current owner.
     */
    function owner() public view virtual returns (address) {
        return _owner;
    }

    /**
     * @dev Throws if the sender is not the owner.
     */
    function _checkOwner() internal view virtual {
        if (owner() != _msgSender()) {
            revert OwnableUnauthorizedAccount(_msgSender());
        }
    }

    /**
     * @dev Leaves the contract without owner. It will not be possible to call
     * `onlyOwner` functions. Can only be called by the current owner.
     *
     * NOTE: Renouncing ownership will leave the contract without an owner,
     * thereby disabling any functionality that is only available to the owner.
     */
    function renounceOwnership() public virtual onlyOwner {
        _transferOwnership(address(0));
    }

    /**
     * @dev Transfers ownership of the contract to a new account (`newOwner`).
     * Can only be called by the current owner.
     */
    function transferOwnership(address newOwner) public virtual onlyOwner {
        if (newOwner == address(0)) {
            revert OwnableInvalidOwner(address(0));
        }
        _transferOwnership(newOwner);
    }

    /**
     * @dev Transfers ownership of the contract to a new account (`newOwner`).
     * Internal function without access restriction.
     */
    function _transferOwnership(address newOwner) internal virtual {
        address oldOwner = _owner;
        _owner = newOwner;
        emit OwnershipTransferred(oldOwner, newOwner);
    }
}

// File: @openzeppelin/contracts/token/ERC20/IERC20.sol


// OpenZeppelin Contracts (last updated v5.0.0) (token/ERC20/IERC20.sol)


/**
 * @dev Interface of the ERC20 standard as defined in the EIP.
 */
interface IERC20 {
    /**
     * @dev Emitted when `value` tokens are moved from one account (`from`) to
     * another (`to`).
     *
     * Note that `value` may be zero.
     */
    event Transfer(address indexed from, address indexed to, uint256 value);

    /**
     * @dev Emitted when the allowance of a `spender` for an `owner` is set by
     * a call to {approve}. `value` is the new allowance.
     */
    event Approval(address indexed owner, address indexed spender, uint256 value);

    /**
     * @dev Returns the value of tokens in existence.
     */
    function totalSupply() external view returns (uint256);

    /**
     * @dev Returns the value of tokens owned by `account`.
     */
    function balanceOf(address account) external view returns (uint256);

    /**
     * @dev Moves a `value` amount of tokens from the caller's account to `to`.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     */
    function transfer(address to, uint256 value) external returns (bool);

    /**
     * @dev Returns the remaining number of tokens that `spender` will be
     * allowed to spend on behalf of `owner` through {transferFrom}. This is
     * zero by default.
     *
     * This value changes when {approve} or {transferFrom} are called.
     */
    function allowance(address owner, address spender) external view returns (uint256);

    /**
     * @dev Sets a `value` amount of tokens as the allowance of `spender` over the
     * caller's tokens.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * IMPORTANT: Beware that changing an allowance with this method brings the risk
     * that someone may use both the old and the new allowance by unfortunate
     * transaction ordering. One possible solution to mitigate this race
     * condition is to first reduce the spender's allowance to 0 and set the
     * desired value afterwards:
     * https://github.com/ethereum/EIPs/issues/20#issuecomment-263524729
     *
     * Emits an {Approval} event.
     */
    function approve(address spender, uint256 value) external returns (bool);

    /**
     * @dev Moves a `value` amount of tokens from `from` to `to` using the
     * allowance mechanism. `value` is then deducted from the caller's
     * allowance.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     */
    function transferFrom(address from, address to, uint256 value) external returns (bool);
}

// File: @openzeppelin/contracts/token/ERC20/extensions/IERC20Metadata.sol


// OpenZeppelin Contracts (last updated v5.0.0) (token/ERC20/extensions/IERC20Metadata.sol)



/**
 * @dev Interface for the optional metadata functions from the ERC20 standard.
 */
interface IERC20Metadata is IERC20 {
    /**
     * @dev Returns the name of the token.
     */
    function name() external view returns (string memory);

    /**
     * @dev Returns the symbol of the token.
     */
    function symbol() external view returns (string memory);

    /**
     * @dev Returns the decimals places of the token.
     */
    function decimals() external view returns (uint8);
}

// File: @openzeppelin/contracts/token/ERC20/ERC20.sol


// OpenZeppelin Contracts (last updated v5.0.0) (token/ERC20/ERC20.sol)






/**
 * @dev Implementation of the {IERC20} interface.
 *
 * This implementation is agnostic to the way tokens are created. This means
 * that a supply mechanism has to be added in a derived contract using {_mint}.
 *
 * TIP: For a detailed writeup see our guide
 * https://forum.openzeppelin.com/t/how-to-implement-erc20-supply-mechanisms/226[How
 * to implement supply mechanisms].
 *
 * The default value of {decimals} is 18. To change this, you should override
 * this function so it returns a different value.
 *
 * We have followed general OpenZeppelin Contracts guidelines: functions revert
 * instead returning `false` on failure. This behavior is nonetheless
 * conventional and does not conflict with the expectations of ERC20
 * applications.
 *
 * Additionally, an {Approval} event is emitted on calls to {transferFrom}.
 * This allows applications to reconstruct the allowance for all accounts just
 * by listening to said events. Other implementations of the EIP may not emit
 * these events, as it isn't required by the specification.
 */
abstract contract ERC20 is Context, IERC20, IERC20Metadata, IERC20Errors {
    mapping(address account => uint256) private _balances;

    mapping(address account => mapping(address spender => uint256)) private _allowances;

    uint256 private _totalSupply;

    string private _name;
    string private _symbol;

    /**
     * @dev Sets the values for {name} and {symbol}.
     *
     * All two of these values are immutable: they can only be set once during
     * construction.
     */
    constructor(string memory name_, string memory symbol_) {
        _name = name_;
        _symbol = symbol_;
    }

    /**
     * @dev Returns the name of the token.
     */
    function name() public view virtual returns (string memory) {
        return _name;
    }

    /**
     * @dev Returns the symbol of the token, usually a shorter version of the
     * name.
     */
    function symbol() public view virtual returns (string memory) {
        return _symbol;
    }

    /**
     * @dev Returns the number of decimals used to get its user representation.
     * For example, if `decimals` equals `2`, a balance of `505` tokens should
     * be displayed to a user as `5.05` (`505 / 10 ** 2`).
     *
     * Tokens usually opt for a value of 18, imitating the relationship between
     * Ether and Wei. This is the default value returned by this function, unless
     * it's overridden.
     *
     * NOTE: This information is only used for _display_ purposes: it in
     * no way affects any of the arithmetic of the contract, including
     * {IERC20-balanceOf} and {IERC20-transfer}.
     */
    function decimals() public view virtual returns (uint8) {
        return 18;
    }

    /**
     * @dev See {IERC20-totalSupply}.
     */
    function totalSupply() public view virtual returns (uint256) {
        return _totalSupply;
    }

    /**
     * @dev See {IERC20-balanceOf}.
     */
    function balanceOf(address account) public view virtual returns (uint256) {
        return _balances[account];
    }

    /**
     * @dev See {IERC20-transfer}.
     *
     * Requirements:
     *
     * - `to` cannot be the zero address.
     * - the caller must have a balance of at least `value`.
     */
    function transfer(address to, uint256 value) public virtual returns (bool) {
        address owner = _msgSender();
        _transfer(owner, to, value);
        return true;
    }

    /**
     * @dev See {IERC20-allowance}.
     */
    function allowance(address owner, address spender) public view virtual returns (uint256) {
        return _allowances[owner][spender];
    }

    /**
     * @dev See {IERC20-approve}.
     *
     * NOTE: If `value` is the maximum `uint256`, the allowance is not updated on
     * `transferFrom`. This is semantically equivalent to an infinite approval.
     *
     * Requirements:
     *
     * - `spender` cannot be the zero address.
     */
    function approve(address spender, uint256 value) public virtual returns (bool) {
        address owner = _msgSender();
        _approve(owner, spender, value);
        return true;
    }

    /**
     * @dev See {IERC20-transferFrom}.
     *
     * Emits an {Approval} event indicating the updated allowance. This is not
     * required by the EIP. See the note at the beginning of {ERC20}.
     *
     * NOTE: Does not update the allowance if the current allowance
     * is the maximum `uint256`.
     *
     * Requirements:
     *
     * - `from` and `to` cannot be the zero address.
     * - `from` must have a balance of at least `value`.
     * - the caller must have allowance for ``from``'s tokens of at least
     * `value`.
     */
    function transferFrom(address from, address to, uint256 value) public virtual returns (bool) {
        address spender = _msgSender();
        _spendAllowance(from, spender, value);
        _transfer(from, to, value);
        return true;
    }

    /**
     * @dev Moves a `value` amount of tokens from `from` to `to`.
     *
     * This internal function is equivalent to {transfer}, and can be used to
     * e.g. implement automatic token fees, slashing mechanisms, etc.
     *
     * Emits a {Transfer} event.
     *
     * NOTE: This function is not virtual, {_update} should be overridden instead.
     */
    function _transfer(address from, address to, uint256 value) internal {
        if (from == address(0)) {
            revert ERC20InvalidSender(address(0));
        }
        if (to == address(0)) {
            revert ERC20InvalidReceiver(address(0));
        }
        _update(from, to, value);
    }

    /**
     * @dev Transfers a `value` amount of tokens from `from` to `to`, or alternatively mints (or burns) if `from`
     * (or `to`) is the zero address. All customizations to transfers, mints, and burns should be done by overriding
     * this function.
     *
     * Emits a {Transfer} event.
     */
    function _update(address from, address to, uint256 value) internal virtual {
        if (from == address(0)) {
            // Overflow check required: The rest of the code assumes that totalSupply never overflows
            _totalSupply += value;
        } else {
            uint256 fromBalance = _balances[from];
            if (fromBalance < value) {
                revert ERC20InsufficientBalance(from, fromBalance, value);
            }
            unchecked {
                // Overflow not possible: value <= fromBalance <= totalSupply.
                _balances[from] = fromBalance - value;
            }
        }

        if (to == address(0)) {
            unchecked {
                // Overflow not possible: value <= totalSupply or value <= fromBalance <= totalSupply.
                _totalSupply -= value;
            }
        } else {
            unchecked {
                // Overflow not possible: balance + value is at most totalSupply, which we know fits into a uint256.
                _balances[to] += value;
            }
        }

        emit Transfer(from, to, value);
    }

    /**
     * @dev Creates a `value` amount of tokens and assigns them to `account`, by transferring it from address(0).
     * Relies on the `_update` mechanism
     *
     * Emits a {Transfer} event with `from` set to the zero address.
     *
     * NOTE: This function is not virtual, {_update} should be overridden instead.
     */
    function _mint(address account, uint256 value) internal {
        if (account == address(0)) {
            revert ERC20InvalidReceiver(address(0));
        }
        _update(address(0), account, value);
    }

    /**
     * @dev Destroys a `value` amount of tokens from `account`, lowering the total supply.
     * Relies on the `_update` mechanism.
     *
     * Emits a {Transfer} event with `to` set to the zero address.
     *
     * NOTE: This function is not virtual, {_update} should be overridden instead
     */
    function _burn(address account, uint256 value) internal {
        if (account == address(0)) {
            revert ERC20InvalidSender(address(0));
        }
        _update(account, address(0), value);
    }

    /**
     * @dev Sets `value` as the allowance of `spender` over the `owner` s tokens.
     *
     * This internal function is equivalent to `approve`, and can be used to
     * e.g. set automatic allowances for certain subsystems, etc.
     *
     * Emits an {Approval} event.
     *
     * Requirements:
     *
     * - `owner` cannot be the zero address.
     * - `spender` cannot be the zero address.
     *
     * Overrides to this logic should be done to the variant with an additional `bool emitEvent` argument.
     */
    function _approve(address owner, address spender, uint256 value) internal {
        _approve(owner, spender, value, true);
    }

    /**
     * @dev Variant of {_approve} with an optional flag to enable or disable the {Approval} event.
     *
     * By default (when calling {_approve}) the flag is set to true. On the other hand, approval changes made by
     * `_spendAllowance` during the `transferFrom` operation set the flag to false. This saves gas by not emitting any
     * `Approval` event during `transferFrom` operations.
     *
     * Anyone who wishes to continue emitting `Approval` events on the`transferFrom` operation can force the flag to
     * true using the following override:
     * ```
     * function _approve(address owner, address spender, uint256 value, bool) internal virtual override {
     *     super._approve(owner, spender, value, true);
     * }
     * ```
     *
     * Requirements are the same as {_approve}.
     */
    function _approve(address owner, address spender, uint256 value, bool emitEvent) internal virtual {
        if (owner == address(0)) {
            revert ERC20InvalidApprover(address(0));
        }
        if (spender == address(0)) {
            revert ERC20InvalidSpender(address(0));
        }
        _allowances[owner][spender] = value;
        if (emitEvent) {
            emit Approval(owner, spender, value);
        }
    }

    /**
     * @dev Updates `owner` s allowance for `spender` based on spent `value`.
     *
     * Does not update the allowance value in case of infinite allowance.
     * Revert if not enough allowance is available.
     *
     * Does not emit an {Approval} event.
     */
    function _spendAllowance(address owner, address spender, uint256 value) internal virtual {
        uint256 currentAllowance = allowance(owner, spender);
        if (currentAllowance != type(uint256).max) {
            if (currentAllowance < value) {
                revert ERC20InsufficientAllowance(spender, currentAllowance, value);
            }
            unchecked {
                _approve(owner, spender, currentAllowance - value, false);
            }
        }
    }
}

// File: @openzeppelin/contracts/token/ERC20/extensions/ERC20Permit.sol


// OpenZeppelin Contracts (last updated v5.0.0) (token/ERC20/extensions/ERC20Permit.sol)







/**
 * @dev Implementation of the ERC20 Permit extension allowing approvals to be made via signatures, as defined in
 * https://eips.ethereum.org/EIPS/eip-2612[EIP-2612].
 *
 * Adds the {permit} method, which can be used to change an account's ERC20 allowance (see {IERC20-allowance}) by
 * presenting a message signed by the account. By not relying on `{IERC20-approve}`, the token holder account doesn't
 * need to send a transaction, and thus is not required to hold Ether at all.
 */
abstract contract ERC20Permit is ERC20, IERC20Permit, EIP712, Nonces {
    bytes32 private constant PERMIT_TYPEHASH =
        keccak256("Permit(address owner,address spender,uint256 value,uint256 nonce,uint256 deadline)");

    /**
     * @dev Permit deadline has expired.
     */
    error ERC2612ExpiredSignature(uint256 deadline);

    /**
     * @dev Mismatched signature.
     */
    error ERC2612InvalidSigner(address signer, address owner);

    /**
     * @dev Initializes the {EIP712} domain separator using the `name` parameter, and setting `version` to `"1"`.
     *
     * It's a good idea to use the same `name` that is defined as the ERC20 token name.
     */
    constructor(string memory name) EIP712(name, "1") {}

    /**
     * @inheritdoc IERC20Permit
     */
    function permit(
        address owner,
        address spender,
        uint256 value,
        uint256 deadline,
        uint8 v,
        bytes32 r,
        bytes32 s
    ) public virtual {
        if (block.timestamp > deadline) {
            revert ERC2612ExpiredSignature(deadline);
        }

        bytes32 structHash = keccak256(abi.encode(PERMIT_TYPEHASH, owner, spender, value, _useNonce(owner), deadline));

        bytes32 hash = _hashTypedDataV4(structHash);

        address signer = ECDSA.recover(hash, v, r, s);
        if (signer != owner) {
            revert ERC2612InvalidSigner(signer, owner);
        }

        _approve(owner, spender, value);
    }

    /**
     * @inheritdoc IERC20Permit
     */
    function nonces(address owner) public view virtual override(IERC20Permit, Nonces) returns (uint256) {
        return super.nonces(owner);
    }

    /**
     * @inheritdoc IERC20Permit
     */
    // solhint-disable-next-line func-name-mixedcase
    function DOMAIN_SEPARATOR() external view virtual returns (bytes32) {
        return _domainSeparatorV4();
    }
}

// File: DragonFireNew.sol

/* $DRAGON Links:
Medium: https://medium.com/@DragonFireAvax
Twitter: @DragonFireAvax
Discord: https://discord.gg/uczFJdMaf4
Telegram: DragonFireAvax
Website: www.DragonFireAvax.com
Email: contact@DragonFireAvax.com
*/

//$DRAGON is an ERC20 token that collects fees on transfers, and creates LP with other top community tokens.
//Base contract imports created with https://wizard.openzeppelin.com/ using their ERC20 with Permit and Ownable.


interface IUniswapV2Factory { 

    function createPair(address tokenA, address tokenB)
        external
        returns (address pair);


    function getPair(address tokenA, address tokenB)
        external
        view
        returns (address pair);

}



interface IUniswapV2Router01 {

    function factory() external pure returns (address);


    function addLiquidity(
        address tokenA,
        address tokenB,
        uint256 amountADesired,
        uint256 amountBDesired,
        uint256 amountAMin,
        uint256 amountBMin,
        address to,
        uint256 deadline
    )
        external
        returns (
            uint256 amountA,
            uint256 amountB,
            uint256 liquidity
        );


    function addLiquidityAVAX(
        address token,
        uint256 amountTokenDesired,
        uint256 amountTokenMin,
        uint256 amountAVAXMin,
        address to,
        uint256 deadline
    )
        external
        payable
        returns (
            uint256 amountToken,
            uint256 amountAVAX,
            uint256 liquidity
        );
}



interface IUniswapV2Router02 is IUniswapV2Router01 {

    function swapExactAVAXForTokensSupportingFeeOnTransferTokens(
        uint256 amountOutMin,
        address[] calldata path,
        address to,
        uint256 deadline
    ) external payable;


    function swapExactTokensForAVAXSupportingFeeOnTransferTokens(
        uint256 amountIn,
        uint256 amountOutMin,
        address[] calldata path,
        address to,
        uint256 deadline
    ) external;
}



interface IERC20Token { //Generic ability to transfer out funds accidentally sent into the contract
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);
    function transfer(address to, uint256 amount) external returns (bool);
    function approve(address spender, uint256 amount) external returns (bool);
}



interface IERC721Token { //Generic ability to transfer out NFTs accidentally sent into the contract
    function transferFrom(address from, address to, uint256 tokenId) external; 
    function safeTransferFrom(address from, address to, uint256 tokenId) external;
    function safeTransfer(address from, address to, uint256 tokenId) external;
    function transfer(address from, address to, uint256 tokenId) external;
}


//ASCII art attributed to -Tua Xiong :

/*
                                        ,   ,
                                        $,  $,     ,
                                        "ss.$ss. .s'
                                ,     .ss$$$$$$$$$$s,
                                $. s$$$$$$$$$$$$$$`$$Ss
                                "$$$$$$$$$$$$$$$$$$o$$$       ,
                               s$$$$$$$$$$$$$$$$$$$$$$$$s,  ,s
                              s$$$$$$$$$"$$$$$$""""$$$$$$"$$$$$,
                              s$$$$$$$$$$s""$$$$ssssss"$$$$$$$$"
                             s$$$$$$$$$$'         `"""ss"$"$s""
                             s$$$$$$$$$$,              `"""""$  .s$$s
                             s$$$$$$$$$$$$s,...               `s$$'  `
                         `ssss$$$$$$$$$$$$$$$$$$$$####s.     .$$"$.   , s-
                           `""""$$$$$$$$$$$$$$$$$$$$#####$$$$$$"     $.$'
                                 "$$$$$$$$$$$$$$$$$$$$$####s""     .$$$|
                                  "$$$$$$$$$$$$$$$$$$$$$$$$##s    .$$" $
                                   $$""$$$$$$$$$$$$$$$$$$$$$$$$$$$$$"   `
                                  $$"  "$"$$$$$$$$$$$$$$$$$$$$S""""'
                             ,   ,"     '  $$$$$$$$$$$$$$$$####s
                             $.          .s$$$$$$$$$$$$$$$$$####"
                 ,           "$s.   ..ssS$$$$$$$$$$$$$$$$$$$####"
                 $           .$$$S$$$$$$$$$$$$$$$$$$$$$$$$#####"
                 Ss     ..sS$$$$$$$$$$$$$$$$$$$$$$$$$$$######""
                  "$$sS$$$$$$$$$$$$$$$$$$$$$$$$$$$########"
           ,      s$$$$$$$$$$$$$$$$$$$$$$$$#########""'
           $    s$$$$$$$$$$$$$$$$$$$$$#######""'      s'         ,
           $$..$$$$$$$$$$$$$$$$$$######"'       ....,$$....    ,$
            "$$$$$$$$$$$$$$$######"' ,     .sS$$$$$$$$$$$$$$$$s$$
              $$$$$$$$$$$$#####"     $, .s$$$$$$$$$$$$$$$$$$$$$$$$s.
   )          $$$$$$$$$$$#####'      `$$$$$$$$$###########$$$$$$$$$$$.
  ((          $$$$$$$$$$$#####       $$$$$$$$###"       "####$$$$$$$$$$
  ) \         $$$$$$$$$$$$####.     $$$$$$###"             "###$$$$$$$$$   s'
 (   )        $$$$$$$$$$$$$####.   $$$$$###"                ####$$$$$$$$s$$'
 )  ( (       $$"$$$$$$$$$$$#####.$$$$$###'                .###$$$$$$$$$$"
 (  )  )   _,$"   $$$$$$$$$$$$######.$$##'                .###$$$$$$$$$$
 ) (  ( \.         "$$$$$$$$$$$$$#######,,,.          ..####$$$$$$$$$$$"
(   )$ )  )        ,$$$$$$$$$$$$$$$$$$####################$$$$$$$$$$$"
(   ($$  ( \     _sS"  `"$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$S$$,
 )  )$$$s ) )  .      .   `$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$"'  `$$
  (   $$$Ss/  .$,    .$,,s$$$$$$##S$$$$$$$$$$$$$$$$$$$$$$$$S""        '
    \)_$$$$$$$$$$$$$$$$$$$$$$$##"  $$        `$$.        `$$.
        `"S$$$$$$$$$$$$$$$$$#"      $          `$          `$
            `"""""""""""""'         '           '           '
*/


/*   888
     888                                        
     888                                        
     888                                        
     888                                        
 .d88888888d888 8888b.  .d88b.  .d88b. 88888b.  
d88" 888888P"      "88bd88P"88bd88""88b888 "88b 
888  888888    .d888888888  888888  888888  888 
Y88b 888888    888  888Y88b 888Y88..88P888  888 
 "Y88888888    "Y888888 "Y88888 "Y88P" 888  888 
                            888                 
                       Y8b d88P                 
                        "Y88P"  
*/

// Compatible with OpenZeppelin Contracts ^5.0.0
pragma solidity 0.8.24;




contract DragonFire is ERC20, ERC20Permit, Ownable {

    uint256 public constant SECONDS_PER_PHASE = 8 minutes; //Seconds per each phase, 8 minutes is 480 seconds
    uint256 public constant TOTAL_PHASES = 8; //Last phase is the public non whale limited phase
    uint256 public constant TOTAL_SUPPLY_WEI = 88888888000000000000000000; //88,888,888 DRAGON

    address public constant DEAD = 0x000000000000000000000000000000000000dEaD; //Burn LP by sending it to this address 
    address public constant WAVAX = 0x5FbDB2315678afecb367f032d93F642f64180aa3; //Hardhat VM 0x5FbDB2315678afecb367f032d93F642f64180aa3
    //WAVAX Mainnet: 0xB31f66AA3C1e785363F0875A1B74E27b85FD66c7 ; Fuji: 0xd00ae08403B9bbb9124bB305C09058E32C39A48c


    IUniswapV2Router02 public uniswapV2Router; //DEX router for swapping Dragon and making all LP pairs on our own new dex
    IUniswapV2Router02[] public uniswapV2Routers; //DEX routers for swapping AVAX for Community Tokens (aka CT) on other dexs

    address[] public communityTokens; //Array of CommunityTokens
    address[] public ctRouters; //Array of CommunityTokens routers, so we can buy each CT on the dex with highest liquidity for it

    address public uniswapV2Pair; //Swap with this pair DRAGON/WAVAX
    address public routerLP; //Main Dragon LP dex router
    address public treasuryAddress; //Team multisig
    address public farmAddress; //Farming rewards treasury

    bool private swapping; //Fees processing reentrancy guard
    bool public phasesInitialized; //Lock phases before IDO launch
    bool public feesLocked; //Option to lock all fees settings

    uint256 public processFeesMinimum; //Minimum DRAGON collected in contract before fees processing, to save gas
    uint256 public communityLPFee; //LP fee divided over all CommunityTokens LP DRAGON/CT, will swap half from DRAGON to make LP
    uint256 public liquidityFee; //LP fee for DRAGON/WAVAX LP, will swap half from DRAGON to make LP
    uint256 public treasuryFee; //Team treasury fee, keep all as DRAGON
    uint256 public farmFee; //Farm fee, keep all as DRAGON
    uint256 public totalFees; //Represented as basis points where 100 == 1%
    uint256 public startTime; //Phases start time
    uint256 public lastTimeCalled; //Last time processFees was called

    mapping (address => bool) public dragonCtPairs; //Track LP pairs for DRAGON/CT
    mapping (address => bool) public approvedRouters; //Approved routers for buying CT with AVAX and making LP
    mapping (address => bool) public isExcludedFromFees; //Swap fees exclusion list
    mapping (address => uint256) public allowlisted; //Allowlist for gated phases
    mapping (address => uint256) public totalPurchased; //Track total purchased by user during gated phases
    mapping (uint256 => uint256) public maxWeiPerPhase; //Maximum DRAGON tokens that can be purchased by a user during some phase


    event SwapAndLiquify( 
        uint256 dragonIntoLiquidity,
        uint256 tokenBIntoLiquidity,
        address indexed tokenB
    ); //Swap for LP event

    event ProcessFees( 
        address indexed user,
        uint256 dragonTokensProcessed
    );

    event SettingsChanged(
        address indexed user,
        string indexed setting
    ); //This is to alert the public that an owner setting has changed, rather than track all the particulars of the setting changed

    event IncludeInFees(
        address indexed userIncluded
    );

    event ExcludeFromFees(
        address indexed userExcluded
    );

    event AvaxWithdraw(
        address indexed to, 
        uint256 amount
    );

    event TokenWithdraw(
        address indexed to, 
        uint256 amount,
        address indexed token
    );

    event TokenApproved(
        address indexed spender, 
        uint256 amount,
        address indexed token
    );

    event NFTWithdraw(
        address indexed to, 
        uint256 ID,
        address indexed token
    );


    modifier feeSettingsLock() {
        require(tradingPhase() == TOTAL_PHASES, "Cannot change fees processing functions until IDO launch is completed");
        require(!feesLocked, "Fees settings are locked forever");
        _;
    }


    modifier phasesLock() {
        require(!phasesInitialized, "Phases initialization is locked");
        _;
    }


    //Change name and symbol to Dragon, DRAGON for actual deployment
    constructor()
    ERC20("Test", "TST")
    ERC20Permit("Test")
    Ownable(msg.sender)
    { //This ERC20 constructor creates our DRAGON token name and symbol. 
      //After allowlist and phases initialization the owner will be set to a multisig 2/3 or 3/5, then later to a community run DAO
        farmAddress = msg.sender; //Update to multisig smart contract wallet until farm is ready
        treasuryAddress = msg.sender;  //Update to multisig smart contract wallet
        communityLPFee = 500; //5%
        liquidityFee = 100; //1%
        treasuryFee = 100; //1%
        farmFee = 100; //1%
        totalFees = communityLPFee + liquidityFee + treasuryFee + farmFee;
        require(totalFees == 800, "Total fees must equal 8% at deployment");

        communityTokens = [0xCf7Ed3AccA5a467e9e704C703E8D87F634fB0Fc9]; //Hardhat VM 0xCf7Ed3AccA5a467e9e704C703E8D87F634fB0Fc9
        //FUJI Testnet Chainlink: 0x0b9d5D9136855f6FEc3c0993feE6E9CE8a297846 
/*                       //Mainnet: 
        [0xab592d197ACc575D16C3346f4EB70C703F308D1E,
        0x420FcA0121DC28039145009570975747295f2329,
        0x184ff13B3EBCB25Be44e860163A5D8391Dd568c1,
        0xb5Cc2CE99B3f98a969DBe458b96a117680AE0fA1,
        0xc06E17bDC3F008F4Ce08D27d364416079289e729,
        0xc8E7fB72B53D08C4f95b93b390ed3f132d03f2D5,
        0x69260B9483F9871ca57f81A90D91E2F96c2Cd11d,
        0x96E1056a8814De39c8c3Cd0176042d6ceCD807d7];    
        //FEED//COQ//KIMBO//LUCKY//DWC//SQRCAT//GGP//OSAK//
*/
        uint256 length_ = communityTokens.length; //Total number of Community Tokens
        require(length_ > 0, "Contract must have at least one community token in rewardsToken array");

        //Choose dex router with best CT/AVAX liquidity for each CT
        ctRouters = [0x9fE46736679d2D9a65F0992F2272dE9f3c7fa6e0]; //Hardhat VM 0x9fE46736679d2D9a65F0992F2272dE9f3c7fa6e0
        //Fuji Testnet: 0xd7f655E3376cE2D7A2b08fF01Eb3B1023191A901
                       //Mainnet: 
/*       [0x60aE616a2155Ee3d9A68541Ba4544862310933d4,
        0x60aE616a2155Ee3d9A68541Ba4544862310933d4,
        0x60aE616a2155Ee3d9A68541Ba4544862310933d4,
        0x60aE616a2155Ee3d9A68541Ba4544862310933d4,
        0x60aE616a2155Ee3d9A68541Ba4544862310933d4,
        0x60aE616a2155Ee3d9A68541Ba4544862310933d4,
        0x60aE616a2155Ee3d9A68541Ba4544862310933d4,
        0x60aE616a2155Ee3d9A68541Ba4544862310933d4];    //(TraderJoe has best liquidity for each CT LP currently)
*/
        require(ctRouters.length == length_, "Each token in the communityTokens array must have a corresponding router in the ctRouters array");
        IUniswapV2Router02 uniswapV2Router_;
        address uniswapV2Pair_;

        //Set all possible routers to true here, so we can switch between these known contracts later if desired
        approvedRouters[0x60aE616a2155Ee3d9A68541Ba4544862310933d4] = true; //TraderJoe router https://support.traderjoexyz.com/en/articles/6807983-contracts-api
        approvedRouters[0xE54Ca86531e17Ef3616d22Ca28b0D458b6C89106] = true; //Pangolin router https://docs.pangolin.exchange/multichain/avalanche-network/contracts

        for (uint256 i = 0; i < length_; i++){
            uniswapV2Router_ = IUniswapV2Router02(ctRouters[i]);
            uniswapV2Routers.push(uniswapV2Router_);
            uniswapV2Pair_ = IUniswapV2Factory(uniswapV2Routers[i].factory()).getPair(communityTokens[i], WAVAX);
            require(uniswapV2Pair_ != address(0), "All CT/WAVAX LP Pairs must be created first and have some LP already, to buy CT with AVAX");
        }

        routerLP = 0x9fE46736679d2D9a65F0992F2272dE9f3c7fa6e0; //Main Dragon/AVAX LP and DRAGON/CT LP dex router
        //Hardhat VM 0x9fE46736679d2D9a65F0992F2272dE9f3c7fa6e0
        //TraderJoe router = C-Chain Mainnet: 0x60aE616a2155Ee3d9A68541Ba4544862310933d4 ; Fuji Testnet: 0xd7f655E3376cE2D7A2b08fF01Eb3B1023191A901
        
        uniswapV2Router_ = IUniswapV2Router02(routerLP);
        uniswapV2Pair_ = IUniswapV2Factory(uniswapV2Router_.factory())
            .createPair(address(this), WAVAX); //Initialize DRAGON/WAVAX LP pair, with 0 LP tokens in it to start with

        uniswapV2Router = uniswapV2Router_; //Uses the interface created above
        uniswapV2Pair = uniswapV2Pair_; //Uses the address created above

        //ExcludeFromFees
        isExcludedFromFees[msg.sender] = true; //Owner is excluded from fees
        isExcludedFromFees[address(this)] = true; //This contract is excluded from fees

        super._update(address(0), msg.sender, TOTAL_SUPPLY_WEI); //Mint total supply to LP creator. They will make LP with 100% of supply and burn LP to the DEAD address
        processFeesMinimum = TOTAL_SUPPLY_WEI / 10000; //Must collect 0.01% of supply in fees before can swap, to save user's gas
        emit SettingsChanged(msg.sender, "constructor");
    }



    // Swap And Burn onlyOwner functions:


    function setMainDex(address router_) external onlyOwner feeSettingsLock{ 
    //There is an inherent risk using a third party dex, so we have the ability to change dexs between approved routers
        require(approvedRouters[router_], "Router not approved"); //Only allow approved routers
        routerLP = router_;
        IUniswapV2Router02 uniswapV2Router_ = IUniswapV2Router02(routerLP);
        uniswapV2Router = uniswapV2Router_; //Uses the interface created above
        address uniswapV2Pair_ = IUniswapV2Factory(uniswapV2Router.factory()).getPair(address(this), WAVAX); //This pair must already exist
        require(uniswapV2Pair_ != address(0), 
        "LP Pair must be created first, paired with WAVAX"); //An invalid LP pair will return 0 address.
        uniswapV2Pair = uniswapV2Pair_; //Set to pair grabbed from the factory call above
        checkCtPairs();
        emit SettingsChanged(msg.sender, "setMainDex");
    }


    function setCommunityTokens(address[] memory addresses_, address[] memory routers_) external onlyOwner feeSettingsLock{ 
    //Set array of community tokens to buy and burn LP for, in case we need to change any.
        uint256 length_ = addresses_.length;
        require(length_ > 0, "Must include at least one community token");
        require(length_ <= 8, "Cannot include more than 8 tokens in the communityTokens array"); //Prevent out of gas errors
        communityTokens = addresses_;
        checkCtPairs();        
        setCtRouters(routers_);
        emit SettingsChanged(msg.sender, "setCommunityTokens");
    }


    function setCtRouters(address[] memory routers_) public onlyOwner feeSettingsLock{ //Can change each dex we buy CT on, to use dex with most LP per CT
        ctRouters = routers_;
        uint256 length_ = communityTokens.length;
        require(ctRouters.length == length_, "Each token in the communityTokens array must have a corresponding router in the ctRouters array");
        address uniswapV2Pair_;
        IUniswapV2Router02 uniswapV2RouterCT_;
        uniswapV2Routers = new IUniswapV2Router02[](length_); //Reset the old array and make size of new length

        for (uint256 i = 0; i < length_; i++){
            require(approvedRouters[routers_[i]], "Router not approved"); //Only allow approved routers
            uniswapV2RouterCT_ = IUniswapV2Router02(routers_[i]);
            uniswapV2Routers[i] = uniswapV2RouterCT_;
            uniswapV2Pair_ = IUniswapV2Factory(uniswapV2Routers[i].factory()).getPair(communityTokens[i], WAVAX);
            require(uniswapV2Pair_ != address(0), "All CT/WAVAX LP Pairs must be created first on new dex, to buy CT with AVAX");
        }

        emit SettingsChanged(msg.sender, "setCtRouters");
    }


    function setProcessFeesMinimum(uint256 amount_) external onlyOwner feeSettingsLock{ //Set minimum amount of Dragon tokens collected as fees to swap and burn with
        require(amount_ >= TOTAL_SUPPLY_WEI / 1000000000, "Amount too low, cannot be less than 0.0000001% of supply"); 
        require(amount_ <= TOTAL_SUPPLY_WEI / 1000, "Amount too high, cannot be more than 0.1% of supply");
        processFeesMinimum = amount_;
        emit SettingsChanged(msg.sender, "setProcessFeesMinimum");
    }


    function setTreasuryAddress(address treasury_) external onlyOwner feeSettingsLock{ //Set address of treasury multisig
        require(treasury_ != address(0), "Cannot set to 0 address");
        isExcludedFromFees[treasury_] = true;  //Add new treasury to fees exclusion list
        isExcludedFromFees[treasuryAddress] = false; //Remove old treasury from fees exclusion list
        treasuryAddress = treasury_;
        emit SettingsChanged(msg.sender, "setTreasuryAddress");
    }


    function setFarmAddress(address farm_) external onlyOwner feeSettingsLock{ //Set address for farm rewards collection
        require(farm_ != address(0), "Cannot set to 0 address");
        isExcludedFromFees[farm_] = true; //Add new farm to fees exclusion list
        isExcludedFromFees[farmAddress] = false; //Remove old farm from fees exclusion list
        farmAddress = farm_;
        emit SettingsChanged(msg.sender, "setFarmAddress");
    }


    function excludeFromFees(address account_) external onlyOwner feeSettingsLock{ //Exclude address from transfer fees
        require(!isExcludedFromFees[account_], "Account is already excluded");
        isExcludedFromFees[account_] = true; //Account is now excluded from fees
        emit ExcludeFromFees(account_);
    }


    function includeInFees(address account_) external onlyOwner feeSettingsLock{ //Remove address from excluded list
        require(isExcludedFromFees[account_], "Account is already included");
        require(account_ != address(this), "Cannot include DRAGON contract in fees");
        isExcludedFromFees[account_] = false; //Account is now no longer excluded from fees
        emit IncludeInFees(account_);
    }


    function transferOwnership(address newOwner_) public override onlyOwner {
        require(newOwner_ != address(0), "Cannot set to 0 address");
        isExcludedFromFees[newOwner_] = true; //Add new owner to fees exclusion list
        isExcludedFromFees[owner()] = false; //Remove old owner from fees exclusion list
        super.transferOwnership(newOwner_);
    }


    function setFeesInBasisPts( //Set transfer fees in basis points where 100 = 1%
        uint256 communityLPFee_, 
        uint256 liquidityFee_, 
        uint256 treasuryFee_, 
        uint256 farmFee_
    ) external onlyOwner feeSettingsLock{
        communityLPFee = communityLPFee_; //LP burn fee to be divided over all community tokens
        liquidityFee = liquidityFee_; //LP fee for DRAGON token LP
        treasuryFee = treasuryFee_; //Team treasury fee
        farmFee = farmFee_; //Farm fee 
        totalFees = communityLPFee + liquidityFee + treasuryFee + farmFee; 
        require(totalFees <= 800, "Total fees cannot add up to over 8%");
        emit SettingsChanged(msg.sender, "setFeesInBasisPts");
    }    


    function lockFeeSettings() external onlyOwner { //Lock fees settings
        require(!feesLocked, "Fees settings already locked");
        feesLocked = true;
        emit SettingsChanged(msg.sender, "lockFeeSettings");
    }


    function setPairs() external onlyOwner{
        uint256 length_ = communityTokens.length;
        address uniswapV2Pair_;

        for (uint256 i = 0; i < length_; i++){
            uniswapV2Pair_ = IUniswapV2Factory(uniswapV2Router.factory()).getPair(address(this), communityTokens[i]);
            if (!dragonCtPairs[uniswapV2Pair_] && uniswapV2Pair_ != address(0)) {
                dragonCtPairs[uniswapV2Pair_] = true;
            }
        }
        emit SettingsChanged(msg.sender, "setPairs");
    }



    //Internal functions:


    function _update( //Fees added on to all transfers, and phases check
        address from_,
        address to_,
        uint256 amount_
    ) internal override(ERC20) {

        if (amount_ == 0) {
            super._update(from_, to_, 0);
            return;
        }

        if (from_ == address(this)
        || to_ == address(this)
        ) { //Don't limit fees processing or LP creation
            super._update(from_, to_, amount_);
            return;
        }
        
        if (swapping) { //Block users during processFees(), in case of reentrant user calls
            revert("User cannot trade in the middle of internal LP creation. You have created a reentrancy issue");
        }

        beforeTokenTransfer(to_, amount_); //Whale limited and timed phases check
        bool takeFee_ = true; 

        if (tradingPhase() == 0 || isExcludedFromFees[from_] || isExcludedFromFees[to_]) { //Don't charge fees when adding LP before launch
            takeFee_ = false;
        }

        if (takeFee_ && totalFees > 0) { //If any fees, then calculate wei amount of DRAGON fees. 
            uint256 fees_ = (amount_ * totalFees) / 10000; //Fees are represented as basis points where 100 is 1% aka 100/10000
            amount_ = amount_ - fees_;
            super._update(from_, address(this), fees_); //Send 8% transfer fee to this contract
        }

        if (to_ == uniswapV2Pair){ //Only force processFees() on a user's sells (and incidentally LP additions)
            uint256 phase_ = tradingPhase();
            if (phase_ != TOTAL_PHASES && phase_ != 0) { //Only force processFees() during whale limited phases, to keep fees from collecting too much at launch.
                processFees();
            }
        }

        super._update(from_, to_, amount_); //Send the original transfer requested by user, minus fees, after processFees() is checked
    }


    function beforeTokenTransfer(
        address to_,
        uint256 amount_
    ) private {
        uint256 tradingPhase_ = tradingPhase();

        if (tradingPhase_ == TOTAL_PHASES){ //No limits on the last phase
            return;
        }

        if (to_ != uniswapV2Pair && !dragonCtPairs[to_]) { //Do not limit LP creation or selling
            require(allowlisted[to_] <= tradingPhase_, "Not allowlisted for current phase");
            totalPurchased[to_] += amount_; //Total amount user received in whale limited phases
            require(totalPurchased[to_] <= maxWeiPerPhase[tradingPhase_], "Receiving too much for current whale limited phase");
        }
    }


    function swapAndBurnLP(uint256 swapToDRAGONLP_, uint256 swapPerCtLP_) private { //Swap half these DRAGON token and make into LPs
        uint256 ctLength_ = communityTokens.length; //Number of CT token addresses in our list
        uint256 totalDRAGONTokens_ = (swapToDRAGONLP_ + (swapPerCtLP_ * ctLength_)); //Total DRAGON tokens to process here

        if (totalDRAGONTokens_ == 0) {
            return;
        }

        uint256 initialAVAXBalance_ = address(this).balance; //Balance before swap for AVAX, for more accurate calculations later
        uint256 halfDRAGONTokens_ = totalDRAGONTokens_ / 2;
        _approve(address(this), address(uniswapV2Router), totalDRAGONTokens_); //Approve main router to swap our DRAGON tokens and make LP
        swapDRAGONForAVAX(halfDRAGONTokens_); //Swap half the DRAGON tokens to AVAX
        uint256 newAVAXBalance_ = address(this).balance - initialAVAXBalance_; //This is the amount of AVAX received from the swap, (or more if someone sent in extra).

        if (swapToDRAGONLP_ > 0) {
            uint256 dragonLpAVAX_ = (swapToDRAGONLP_  * newAVAXBalance_) / totalDRAGONTokens_; //Calculate ratio and amount of AVAX to be used for DRAGON/WAVAX LP.
            uint256 halfDRAGONForLP_ = swapToDRAGONLP_ / 2; //Calculate DRAGON tokens earmarked for DRAGON/WAVAX LP
            addLiquidityDRAGON(halfDRAGONForLP_, dragonLpAVAX_); //Make LP for DRAGON/WAVAX LP, and burn it
            newAVAXBalance_ -= dragonLpAVAX_; //Calculate remaining AVAX to use for all DRAGON/CT LPs we will make next
            emit SwapAndLiquify(halfDRAGONForLP_, dragonLpAVAX_, WAVAX);
        }

        if (swapPerCtLP_ > 0) {
            uint256 avaxPerCt_ = newAVAXBalance_ / ctLength_; //Calculate AVAX to swap for tokens for CT half of LP pair, divided for each DRAGON/CT LP.
            uint256 dragonPerCtLP_ = swapPerCtLP_ / 2; //Calculate tokens for DRAGON half of LP pair

            for (uint256 i = 0; i < ctLength_; i++){ //Loop for each CT
                uint256 initialCtBalance_ = IERC20(communityTokens[i]).balanceOf(address(this));
                swapAvaxForCT(avaxPerCt_, i);
                uint256 newCtBalance_ = IERC20(communityTokens[i]).balanceOf(address(this)) - initialCtBalance_;
                addLiquidityCT(dragonPerCtLP_, newCtBalance_, communityTokens[i]);
                emit SwapAndLiquify(dragonPerCtLP_, newCtBalance_, communityTokens[i]);
            }
        }
    }


    function swapDRAGONForAVAX(uint256 tokenAmount_) private {
        address[] memory path = new address[](2); //Our swap path DRAGON/WAVAX
        path[0] = address(this); //DRAGON
        path[1] = WAVAX; //WAVAX

        try
        uniswapV2Router.swapExactTokensForAVAXSupportingFeeOnTransferTokens( //DRAGON to AVAX swap on main dex
            tokenAmount_,
            100, //Infinite slippage basically since it's in wei
            path,
            address(this), //Send the AVAX we receive from the swap to this contract
            block.timestamp)
        {}
        catch {
            revert(string("swapDRAGONForAVAX failed"));
        }
    }


    function swapAvaxForCT(uint256 avaxAmount_, uint256 index_) private {
        address[] memory path = new address[](2); //Our swap path WAVAX/CT
        path[0] = WAVAX; //WAVAX
        path[1] = communityTokens[index_]; //CT

        try  
        uniswapV2Routers[index_].swapExactAVAXForTokensSupportingFeeOnTransferTokens //AVAX to CT, swap on dex router with most LP
        {value: avaxAmount_}(
            100, //Infinite slippage basically since it's in wei
            path,
            address(this), //Send CT tokens received to this contract
            block.timestamp)
        {}
        catch {
            revert(string("swapAvaxForCT failed"));
        }
    }


    function addLiquidityDRAGON(uint256 tokenAmount_, uint256 avaxAmount_)  private { //Make and burn LP tokens DRAGON/WAVAX
        try  
        uniswapV2Router.addLiquidityAVAX{value: avaxAmount_}( //Amount of AVAX to send for LP on main dex
            address(this),
            tokenAmount_,
            100, //Infinite slippage basically since it's in wei
            100, //Infinite slippage basically since it's in wei
            DEAD, //Burn LP
            block.timestamp)
        {}
        catch {
            revert(string("addLiquidityDRAGON failed"));
        }
    }


    function addLiquidityCT(uint256 dragonAmount_, uint256 ctAmount_, address ctAddress_)  private {  //Make and burn LP tokens DRAGON/CT or DRAGON/WAVAX on main dex
        IERC20(ctAddress_).approve(address(uniswapV2Router), ctAmount_); //Approve token transfer for router to make LP

        //Add the liquidity
        try  
        uniswapV2Router.addLiquidity(
            address(this), //DRAGON
            ctAddress_, //CT or WAVAX
            dragonAmount_,
            ctAmount_,
            100, //Infinite slippage basically since it's in wei
            100, //Infinite slippage basically since it's in wei
            DEAD, //Burn LP
            block.timestamp)
        {}
        catch {
            revert(string("addLiquidityCT failed"));
        }
    }


    function checkCtPairs() internal view {
        uint256 length_ = communityTokens.length;
        address uniswapV2Pair_;
        for (uint256 i = 0; i < length_; i++){
            uniswapV2Pair_ = IUniswapV2Factory(uniswapV2Router.factory()).getPair(address(this), communityTokens[i]);
            require(uniswapV2Pair_ != address(0), "All CT/DRAGON LP Pairs must be created first on main dex");
        }
    }


    //Public functions:


    function processFees() public {  //Swap DRAGON fees for community tokens, make into LP, and burn LP
        if(tradingPhase() == TOTAL_PHASES){ //If IDO phases are completed, then prevent back to back dumps
            require(block.timestamp >= (lastTimeCalled + SECONDS_PER_PHASE), "Cannot process fees more than once every 8 minutes"); //Prevent back to back fees dumping
            lastTimeCalled = block.timestamp;
        }

        //Multiply first, then divide, using () to order the operations, like (x * y) / z
        uint256 maxProcessFees_ = (balanceOf(uniswapV2Pair) * 8) / 100; //Cannot process fees totalling more than 8% of DRAGON in the LP at once, to reduce price dump
        uint256 contractDRAGONBalance_ = balanceOf(address(this));
        uint256 amountOfFees_; //Amount of fees to process now
        if (contractDRAGONBalance_ < maxProcessFees_){
            amountOfFees_ = contractDRAGONBalance_;
        } else {
            amountOfFees_ = maxProcessFees_;
        }

        bool canSwap_ = amountOfFees_ >= processFeesMinimum; //Must have the minimum amount of fees collected to process them

        if (canSwap_ && !swapping) {
            if (totalFees == 0) {
                super._update(address(this), DEAD, contractDRAGONBalance_); //Burn any remaining fees if not collecting them anymore
                return;
            }
            
            swapping = true; //Reentrancy guard

            //Multiply first, then divide, using () to order the operations, like (x * y) / z
            uint256 swapToCtLP_ = (amountOfFees_ * communityLPFee) / totalFees; //Calculate community tokens LP fee portion
            uint256 swapToDRAGONLP_ = (amountOfFees_ * liquidityFee) / totalFees; //Calculate DRAGON LP fee portion
            uint256 farmTokens_ = (amountOfFees_ * farmFee) / totalFees; //Calculate farm fee portion
            uint256 treasuryTokens_ = (amountOfFees_ * treasuryFee) / totalFees; //Calculate treasury fee portion

            uint256 swapPerCtLP_ =  swapToCtLP_ / communityTokens.length; //Make sure total amount of CT LP is divisible by CT tokens
            uint256 remainder_ = amountOfFees_ - (swapToDRAGONLP_ + farmTokens_ + treasuryTokens_ + (swapPerCtLP_ * communityTokens.length)); //Calculate dust leftover
            swapToDRAGONLP_ += remainder_; //Add dust to DRAGON LP portion

            if (treasuryTokens_ > 0){
                super._update(address(this), treasuryAddress, treasuryTokens_); //Send fees to treasuryAddress
            }

            if (farmTokens_ > 0){
                super._update(address(this), farmAddress, farmTokens_); //Send fees to farm
            }

            swapAndBurnLP(swapToDRAGONLP_, swapPerCtLP_);
            swapping = false; //Reentrancy guard
            uint256 newDRAGONBalance_ = balanceOf(address(this)); //Calculate any dust leftover from CT LP creation
            emit ProcessFees(msg.sender, (contractDRAGONBalance_ - newDRAGONBalance_)); //Amount of DRAGON fees processed minus any dust leftover
        } else {
            if (swapping){
               revert("Cannot process now, already in the middle of processing fees. You have created a reentrancy issue");
            }

            if (!canSwap_ && tradingPhase() == TOTAL_PHASES){ //Don't revert forced fees processing of whale limited phases
               revert("Cannot process yet, more fees need to be collected first");
            }
        }
    }


    function seedAndBurnCtLP(uint256 ctIndex_, address communityToken_, uint256 amountDragon_, uint256 amountCt_) external {
        require(tradingPhase() != TOTAL_PHASES, "Phases are completed already"); //This function is just to seed LP for IDO launch
        require(communityTokens[ctIndex_] == communityToken_, "Token not found in communityTokens array at that index"); //Verify valid CT address
        require(amountDragon_ > 100000000000000000, "Must send at least 0.1 Dragon tokens");
        require(amountCt_ > 100000000000000000, "Must send at least 0.1 Community tokens");
        require(!swapping, "Already making CT LP, you have created a reentrancy issue");
        swapping = true; //Reentrancy block
        transfer(address(this), amountDragon_);
        IERC20(communityToken_).transferFrom(msg.sender, address(this), amountCt_); //User must first approve this contract to spend their CT tokens
        _approve(address(this), address(uniswapV2Router), amountDragon_); //Approve main router to use our DRAGON tokens and make LP
        addLiquidityCT(amountDragon_, amountCt_, communityToken_);
        swapping = false;
        emit SwapAndLiquify(amountDragon_,amountCt_, communityToken_);
    }
    

    function seedAndBurnDragonLP(uint256 amountDragon_, uint256 amountAvax_) external payable {
        require(tradingPhase() != TOTAL_PHASES, "Phases are completed already"); //This function is just to seed LP for IDO launch
        require(msg.value == amountAvax_, "Different amount of Avax sent than indicated in call values"); //Verify intended amount sent
        require(amountDragon_ >= 100000000000000000, "Must send at least 0.1 Dragon tokens");
        require(amountAvax_ >= 100000000000000000, "Must send at least 0.1 AVAX");
        require(!swapping, "Already making Dragon LP, you have created a reentrancy issue");
        swapping = true; //Reentrancy block
        transfer(address(this), amountDragon_);
        _approve(address(this), address(uniswapV2Router), amountDragon_); //Approve main router to use our DRAGON tokens and make LP
        addLiquidityDRAGON(amountDragon_, amountAvax_);
        swapping = false;
        emit SwapAndLiquify(amountDragon_, amountAvax_, WAVAX);
    }


    function tradingActive() public view returns (bool) { //Check if startTime happened yet to open trading
        if (startTime > 0  && phasesInitialized) {
            return block.timestamp >= startTime; //Return true if phases is set and has started
        } else {
            return false;
        }
    }


    function tradingRestricted() public view returns (bool) { //Check if we are in allowlist phases
        return tradingActive() && block.timestamp <= (startTime + (SECONDS_PER_PHASE * (TOTAL_PHASES - 1))); //True if tradingActive, but whale limited phases is not over
    }


    function tradingPhase() public view returns (uint256 phase) { //Check the phase
        if (!tradingActive()) {
            return 0; //0 == No buying
        }

        uint256 secondsPastStart_ = block.timestamp - startTime;
        uint256 phase_ = (secondsPastStart_ / SECONDS_PER_PHASE) + 1; //Count phase periods elapsed to see what phase we are in

        if (phase_ > TOTAL_PHASES) {
            phase_ = TOTAL_PHASES;
        }

        return phase_;
    }



    //Set Phases onlyOwner:


    function setPhasesStartTime(uint256 startTime_) external onlyOwner phasesLock{
        require(startTime_ > 0, "Start time must be greater than 0");
        startTime = startTime_;
        emit SettingsChanged(msg.sender, "setPhasesStartTime");
    }


    function setWhaleLimitsPerPhase(uint256[] memory maxWei_) external onlyOwner phasesLock{
        uint256 length_ = maxWei_.length;
        require(length_ == (TOTAL_PHASES - 1), "You must set maximum wei for every whale limited phase");
        uint256 previousPhaseMaxWei_;
        require(maxWei_[0] > 0, "Whale limit must be greater than 0 wei");
        for (uint256 i = 0; i < length_; i++){
            require(maxWei_[i] >= previousPhaseMaxWei_, "Max amount users can hold must increase or stay the same through the phases.");
            maxWeiPerPhase[i+1] = maxWei_[i]; //Max phase 1 = maxWei_[0] 
            previousPhaseMaxWei_ = maxWei_[i];
        }
        emit SettingsChanged(msg.sender, "setWhaleLimitsPerPhase");
    }


    function lockPhasesSettings() external onlyOwner phasesLock{ //Phases initialization cannot be unlocked after it is locked
        require(startTime >= block.timestamp, "startTime must be set for the future");
        require(maxWeiPerPhase[1] > 0 , "Whale limited phases maxWeiPerPhase must be greater than 0");
        checkCtPairs();
        phasesInitialized = true; //Lock these phases settings
        emit SettingsChanged(msg.sender, "lockPhasesSettings");
    }


    function setAllowlistedForSomePhase(address[] memory users_, uint256 phase_) external onlyOwner {
        require(phase_ <= TOTAL_PHASES, "Phases are already completed");
        uint256 length_ = users_.length;
        require(length_ > 0, "Must include at least one user");
        require(length_ <= 200, "Cannot add more than 200 users in one transaction"); //Prevent out of gas errors  
        for (uint256 i = 0; i < length_; i++) {
            allowlisted[users_[i]] = phase_;
        }
        emit SettingsChanged(msg.sender, "setAllowlistedForSomePhase");
    }



    //Fallback function and generic transfer functions to handle any tokens that come into contract:


    fallback() external payable {}

    receive() external payable {}

    function withdrawAvaxTo(address payable to_, uint256 amount_) external onlyOwner {
        require(to_ != address(0), "Cannot withdraw to 0 address");
        to_.transfer(amount_); //Can only send Avax from our contract, any user's wallet is safe
        emit AvaxWithdraw(to_, amount_);
    }

    function iERC20TransferFrom(address contract_, address to_, uint256 amount_) external onlyOwner {
        noDRAGONTokens(contract_);  //Cannot transfer DRAGON tokens
        (bool success) = IERC20Token(contract_).transferFrom(address(this), to_, amount_); //Can only transfer from our own contract
        require(success, 'token transfer from sender failed');
        emit TokenWithdraw(to_, amount_, contract_);
    }

    function iERC20Transfer(address contract_, address to_, uint256 amount_) external onlyOwner {
        noDRAGONTokens(contract_);  //Cannot transfer DRAGON tokens
        (bool success) = IERC20Token(contract_).transfer(to_, amount_); 
        //Since interfaced contract looks at msg.sender then this can only send from our own contract
        require(success, 'token transfer from sender failed');
        emit TokenWithdraw(to_, amount_, contract_);
    }

    function iERC20Approve(address contract_, address spender_, uint256 amount_) external onlyOwner {
        noDRAGONTokens(contract_);  //Cannot transfer DRAGON tokens
        IERC20Token(contract_).approve(spender_, amount_); //Since interfaced contract looks at msg.sender then this can only send from our own contract
        emit TokenApproved(spender_, amount_, contract_);
    }

    function iERC721TransferFrom(address contract_, address to_, uint256 tokenId_) external onlyOwner {
        noDRAGONTokens(contract_);  //Cannot transfer DRAGON tokens
        IERC721Token(contract_).transferFrom(address(this), to_, tokenId_); //Can only transfer from our own contract
        emit NFTWithdraw(to_, tokenId_, contract_);
    }

    function iERC721SafeTransferFrom(address contract_, address to_, uint256 tokenId_) external onlyOwner {
        noDRAGONTokens(contract_);  //Cannot transfer DRAGON tokens
        IERC721Token(contract_).safeTransferFrom(address(this), to_, tokenId_); //Can only transfer from our own contract
        emit NFTWithdraw(to_, tokenId_, contract_);
    }

    function iERC721Transfer(address contract_, address to_, uint256 tokenId_) external onlyOwner {
        noDRAGONTokens(contract_);  //Cannot transfer DRAGON tokens
        IERC721Token(contract_).transfer( address(this), to_, tokenId_); //Can only transfer from our own contract
        emit NFTWithdraw(to_, tokenId_, contract_);
    }

    function iERC721SafeTransfer(address contract_, address to_, uint256 tokenId_) external onlyOwner {
        noDRAGONTokens(contract_);  //Cannot transfer DRAGON tokens
        IERC721Token(contract_).safeTransfer( address(this), to_, tokenId_); //Can only transfer from our own contract
        emit NFTWithdraw(to_, tokenId_, contract_);
    }

    function noDRAGONTokens(address contract_)  internal view {
        require(contract_ != address(this), "Owner cannot withdraw $DRAGON token fees collected"); //No $DRAGON tokens, as they are earmarked for fees processing
        require(!swapping, "Owner cannot withdraw while fees are processing"); //Reentrancy guard prevents CT tokens being removed during fees processing
    }

}

//"May the dragon's song bring harmony." -Harmony Scales




  //Legal Disclaimer: 
// DragonFire (DRAGON) is a meme coin (also known as a community token) created for entertainment purposes only. 
//It holds no intrinsic value and should not be viewed as an investment opportunity or a financial instrument.
//It is not a security, as it promises no financial returns to buyers, and does not rely solely on the efforts of the creators and developers.

// There is no formal development team behind DRAGON, and it lacks a structured roadmap. 
//Users should understand that the project is experimental and may undergo changes or discontinuation without prior notice.

// DRAGON serves as a platform for the community to engage in activities such as liquidity provision and token swapping on the Avalanche blockchain. 
//It aims to foster community engagement and collaboration, allowing users to participate in activities that may impact the value of their respective tokens.

// It's important to note that the value of DRAGON and associated community tokens may be subject to significant volatility and speculative trading. 
//Users should exercise caution and conduct their own research before engaging with DRAGON or related activities.

// Participation in DRAGON-related activities should not be solely reliant on the actions or guidance of developers. 
//Users are encouraged to take personal responsibility for their involvement and decisions within the DRAGON ecosystem.

// By interacting with DRAGON or participating in its associated activities, 
//users acknowledge and accept the inherent risks involved and agree to hold harmless the creators and developers of DRAGON from any liabilities or losses incurred.




/*
   Launch instructions:
Set values in the constructor, and constant values at the start of the contract.
Deploy contract with solidity version: 0.8.24, EVM version: Paris, and runs optimized: 200.
Verify contract.
Add all dragon tokens as LP using the functions in the contract during Phase 0, so all 8 tokens have starter LP DRAGON/CT, then run setPairs() to save the pairs.
All DRAGON tokens are now in LP, there are no initial team tokens or other initial distributions.
Initialize phases startTime for some future time, set whale limits per phase, and finally ***lock phases***.
Set allowlists that we have so far for each phase.
Set socials on block explorer and dexscreener.
Transfer contract ownership to multisig, requiring multiple signatures per transaction, where each signer is a unique person and wallet and device.
Release medium article showing tokenomics, audit report, DEXs, LP burnt, contract address, farm collection address, treasury address, and multisig signer addresses.
IDO launch after marketing and bonus allowlist gathered and input.
Later, transfer contract ownership to a community run and owned DAO, possibly with 48hr timelocks in effect, which might use the OpenZeppelin Defender voting system.
Bug bounty could be good to set up on https://www.sherlock.xyz/ or https://code4rena.com/ or similar.
Optional future upgrade of processFees() to external contract that might implement slippage protections, V4 LP, or other features.
*/