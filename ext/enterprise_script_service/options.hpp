#ifndef ENTERPRISE_SCRIPT_SERVICE_OPTIONS_HPP
#define ENTERPRISE_SCRIPT_SERVICE_OPTIONS_HPP

#include <ctype.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sstream>
#include <iostream>

class options {
public:
  options();

  uint64_t instruction_quota();
  uint32_t instruction_quota_start();

  void read_from(int argc, char **argv, std::ostream &output = std::cerr);
private:
  uint64_t instruction_quota_;
  uint32_t instruction_quota_start_;

  inline void parse(std::ostream &output, uint64_t &to, const std::string &option = "option");
};

#endif
