# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: adbenoit <adbenoit@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/04/24 11:47:18 by adbenoit          #+#    #+#              #
#    Updated: 2020/08/12 23:57:06 by adbenoit         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

NAME	=	test_cub3d

CUB3D_DIR	= ..

CUB3D	= $(CUB3D_DIR)/cub3D

COMP_DIR= srcs/compare

COMP	= $(COMP_DIR)/comp

ADD_DIR= srcs/add_bonus_inf

ADD	= $(ADD_DIR)/add

all : $(NAME) $(CUB3D) $(COMP)

$(NAME) :
	@make -C $(COMP_DIR)
	@make -C $(CUB3D_DIR)

bonus :
	@make -C $(COMP_DIR)
	@make -C $(ADD_DIR)
	@make bonus -C $(CUB3D_DIR)

clean :
	@make -C $(CUB3D_DIR) clean
	@make -C $(COMP_DIR) clean
	@make -C $(ADD_DIR) clean

fclean : clean
	@rm -rf $(NAME)
	@rm -rf $(CUB3D) 
	@rm -rf $(COMP)
	@rm -rf $(ADD)

re : fclean all

.PHONY: all clean fclean re bonus