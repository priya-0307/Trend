 module "eks" {
      source  = "terraform-aws-modules/eks/aws"
      version = "~> 20.0"

    

      vpc_id     = module.vpc.vpc_id
      subnet_ids = module.vpc.private_subnets

      enable_irsa = true

      eks_managed_node_group_defaults = {
        ami            = "ami-02b8269d5e85954ef"
        instance_types = "t2.micro"
      }

      eks_managed_node_groups = {
        default_node_group = {
          min_size     = 2
          max_size     = 5
          desired_size = 3
        }
      }
    }
