#pragma once

#include <string>

namespace jet {

// A placeholder for a future message implementation.
class Message {
 public:
  Message() = default;
  std::string serialize() const;
  void deserialize(const std::string& data) const;
};

}  // namespace jet
