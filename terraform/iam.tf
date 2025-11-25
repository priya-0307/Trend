# IAM role for  ec2
    resource "aws_iam_policy" "ec2_s3_access_policy" {
      name        = "ec2-s3-access-policy"
      description = "Allows EC2 instances to access S3 buckets."
      policy = jsonencode({
        Version = "2012-10-17"
        Statement = [
          {
            Action = [
              "s3:GetObject",
              "s3:ListBucket"
            ]
            Effect   = "Allow"
            Resource = ["arn:aws:s3:::s3-bucket", "arn:aws:s3:::s3-bucket/*"]
          }
        ]
      })
    }



# IAM role for jenkins

resource "aws_iam_role" "jenkins_role" {
  name = "jenkins-ec2-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })

  tags = {
    Name = "jenkins-ec2-role"
  }

}
