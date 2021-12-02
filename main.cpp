


//! example
#include "WintersEngine.h"
#include "Constant/TSingleton.h"

#include <boost/thread.hpp>


namespace WE {

enum class Thread_Layer : uchar {
	Bottom = 0,
	Middle,
	Top,
};

class Thread : public boost::thread {
	
public:
	


private:
	Thread_Layer layer;

};
} // namespace::WE


namespace WE {



} // namespace::WE


class ThreadManager : public TSingleton<ThreadManager> {
	
public:


private:
	hashmap<int, WE::Thread> thread_hashmap;

};




int main() {
	

	//std::cout << (2 ^ 8) << std::endl;

	return 0;
}