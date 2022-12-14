%lang starknet
from starkware.cairo.common.math import assert_nn
from starkware.cairo.common.cairo_builtins import HashBuiltin

@storage_var
func balance() -> (res: felt) {
}

// @notice inc balance
// @dev inc balance
// @param amount_2 this is a pre-generated parameter
@external
func increase_balance{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
    amount: felt, amount_2: felt
) {
    with_attr error_message("Amount must be positive. Got: {amount}.") {
        assert_nn(amount);
    }

    let (res) = balance.read();
    balance.write(res + amount);
    return ();
}

// @inheritdoc
@view
func get_balance{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}() -> (res: felt) {
    let (res) = balance.read();
    return (res,);
}

@constructor
func constructor{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}() {
    balance.write(0);
    return ();
}

namespace Namespace {
    func under_namespace{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
        param1: felt, param2: felt
    ) -> (res: felt) {
        return ();
    }

    // @returns Uint256 for tests
    func no_tuple_ret{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
        param1: felt
    ) -> felt {
        return 1;
    }
}
