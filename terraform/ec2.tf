resource "aws_instance" "jenkins" {
  ami           = "ami-02b8269d5e85954ef"
  instance_type = "t2.medium"

  tags = {
    Name = "my-project-2"
  }
}