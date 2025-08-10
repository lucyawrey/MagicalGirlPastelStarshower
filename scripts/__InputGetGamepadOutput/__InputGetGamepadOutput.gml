// Feather disable all

function __InputGetGamepadOutput(_device) {
	//TODO - Is it faster to do this all in one if-statement?
	if (INPUT_BAN_GAMEPADS) {
		return undefined;
	}
	if (_device < 0) {
		return undefined;
	}
	if (!InputGameHasFocus()) {
		return undefined;
	}
	if (!InputDeviceIsConnected(_device)) {
		return undefined;
	}
	if (!gamepad_is_connected(_device)) {
		return undefined;
	}

	var _readArray = __InputGamepadGetReadArray(_device);

	var _binding = INPUT_GAMEPAD_BINDING_MIN;
	repeat (1 + INPUT_GAMEPAD_BINDING_MAX - INPUT_GAMEPAD_BINDING_MIN) {
		if (
			abs(_readArray[_binding - INPUT_GAMEPAD_BINDING_MIN](_device, _binding))
			> INPUT_GAMEPAD_THUMBSTICK_MIN_THRESHOLD
		) {
			return _binding;
		}

		++_binding;
	}

	return undefined;
}
