#pragma once

#include <iostream>

#include <string>

#include <memory>
#include <memory_resource>
#include <algorithm>

#include <vector>
#include <array>
#include <map>
#include <unordered_map>
#include <set>


// define
//typedef char				char;
typedef unsigned char		uchar;
//typedef short				short;
typedef unsigned short		ushort;
//typedef int				int;
typedef unsigned int		uint;
//typedef long				long;
typedef unsigned long		ulong;
typedef long long			decimal;
typedef unsigned long long	udecimal;
//typedef float				float;
typedef double				real;
typedef std::wstring		str;

//template<class T>
//using vectory = std::vector<T>;
//template<class T>
//using array = std::array<T>;
//template<class T>
//using map = std::map<T>;

template <class Key, class T, class Hash = std::hash<Key>, class Pred = std::equal_to<Key>>
using hashmap = std::unordered_map<Key, T, Hash, Pred>;

//template<class T>
//using set = std::set<T>;