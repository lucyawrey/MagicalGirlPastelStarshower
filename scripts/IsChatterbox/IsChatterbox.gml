// Feather disable all
/// Returns if the given value is a chatterbox created by ChatterboxCreate()
///
/// @param value

function IsChatterbox(value)
{
    return (instanceof(value) == "__ChatterboxClass");
}
