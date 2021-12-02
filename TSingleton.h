#pragma once
#include <boost/serialization/singleton.hpp>

template<class T>
class TSingleton {

public:
	TSingleton(TSingleton<T> const&) = delete;
	TSingleton(TSingleton<T>&&) = delete;
	TSingleton& operator = (TSingleton<T> const&) = delete;
	TSingleton& operator = (TSingleton<T>&&) = delete;

	BOOST_DLLEXPORT static T& Get_Write_Instance() {
		BOOST_ASSERT(false == boost::serialization::get_singleton_module().is_locked());
		return _Get_Instance();
	}

	BOOST_DLLEXPORT static const T& Get_Read_Instance() {
		return _Get_Instance();
	}

	BOOST_DLLEXPORT static bool Is_Detroyed() {
		return boost::serialization::detail::singleton_wrapper<T>::is_destroyed();
	}

protected:
	BOOST_DLLEXPORT TSingleton() = default;

private:
	static T* _instance;

	static void Use(T const&) {}
	static T& _Get_Instance() {
		BOOST_ASSERT(false == Is_Detroyed());
		static boost::serialization::detail::singleton_wrapper<T> t;
		if (_instance) Use(*_instance);
		return static_cast<T&>(t);
	}
};

template<class T>
T* TSingleton<T>::_instance = &TSingleton<T>::_Get_Instance();