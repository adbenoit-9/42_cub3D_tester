# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: adbenoit <adbenoit@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/04/24 11:47:18 by adbenoit          #+#    #+#              #
#    Updated: 2020/04/24 17:40:56 by adbenoit         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

NAME	=	test_cub3d

CUB3D_DIR	= ..

CUB3D	= $(CUB3D_DIR)/cub3d

COMP_DIR= srcs

COMP	= $(COMP_DIR)/comp

all : $(NAME) $(CUB3D) $(COMP)

$(NAME) :
	@make -C $(COMP_DIR)
	@make -C $(CUB3D_DIR)

clean :
	@make -C $(CUB3D_DIR) clean
	@make -C $(COMP_DIR) clean

fclean : clean
	@rm -rf $(NAME)
	@rm -rf $(CUB3D) 
	@rm -rf $(COMP)

re : fclean all

.PHONY: all clean fclean re save