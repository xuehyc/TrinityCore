/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#ifndef EnumClassFlag_h__
#define EnumClassFlag_h__

#include <type_traits>

template<typename T>
class EnumClassFlag
{
    static_assert(std::is_enum<T>::value, "EnumClassFlag must be used only with enums");

public:
    /*implicit*/ EnumClassFlag(T value) : _value(value) { }

    EnumClassFlag& operator&=(EnumClassFlag right)
    {
        _value = static_cast<T>(static_cast<std::underlying_type_t<T>>(_value) & static_cast<std::underlying_type_t<T>>(right._value));
        return *this;
    }

    friend EnumClassFlag operator&(EnumClassFlag left, EnumClassFlag right)
    {
        return left &= right;
    }

    EnumClassFlag operator|=(EnumClassFlag right)
    {
        _value = static_cast<T>(static_cast<std::underlying_type_t<T>>(_value) | static_cast<std::underlying_type_t<T>>(right._value));
        return *this;
    }

    friend EnumClassFlag operator|(EnumClassFlag left, EnumClassFlag right)
    {
        return left |= right;
    }

    EnumClassFlag operator~() const
    {
        return static_cast<T>(~static_cast<std::underlying_type_t<T>>(_value));
    }

    void RemoveFlag(EnumClassFlag flag)
    {
        _value = static_cast<T>(static_cast<std::underlying_type_t<T>>(_value) & ~static_cast<std::underlying_type_t<T>>(flag._value));
    }

    bool HasFlag(T flag) const
    {
        return (static_cast<std::underlying_type_t<T>>(_value) & static_cast<std::underlying_type_t<T>>(flag)) != 0;
    }

    operator T() const
    {
        return _value;
    }

    std::underlying_type_t<T> AsUnderlyingType() const
    {
        return static_cast<std::underlying_type_t<T>>(_value);
    }

private:
    T _value;
};

#endif // EnumClassFlag_h__
