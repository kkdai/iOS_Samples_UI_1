//
//  main.cpp
//  test
//
//  Created by Evan Lin on 2014/12/25.
//  Copyright (c) 2014年 EvanLin. All rights reserved.
//

#include <iostream>
#include <vector>
#include <string>

int main(int argc, const char * argv[]) {
    //Init new vector here
    std::vector<std::string> v;
    
    //v.reserve(5);
    //Put first element "hello" v: "Hello"
    v.push_back("Hello");
    std::cout << v.capacity() << '\n';
    // x refer to v[0] which is "Hello"
    std::string& x = v[0];
    
    //Push new element but size will over capacity (default is zero, after first push become 1)
    //So whole memory will deprence and create new memory size =2
    //Refer to http://en.cppreference.com/w/cpp/container/vector/push_back
    v.push_back("world");
    
    // Old reference memory aleady become to garbage, so app crash (depends OS)
    std::cout << x;    
    return 0;
}
