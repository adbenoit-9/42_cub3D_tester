NAME = comp

SRC =	ft_compare.c\
		../get_next_line.c\
		../get_next_line_utils.c

OBJ_PATH = obj

OBJ_NAME	= $(SRC:.c=.o)

OBJ	= $(addprefix $(OBJ_PATH)/,$(OBJ_NAME))

all : $(NAME)

CC = gcc

CFLAGS	= -Wall -Werror -Wextra

$(NAME): $(OBJ)
	@$(CC) -o $(NAME) $(OBJ)

$(OBJ_PATH)/%.o:	%.c
	@mkdir $(OBJ_PATH) 2> /dev/null || true
	@$(CC) -o $@ -c $< $(CFLAGS)

clean:
	@rm -f $(OBJ)
	@rm -rf $(OBJ_PATH)

fclean:	clean
	@rm -rf $(NAME)

re: fclean all

.PHONY: all clean fclean re