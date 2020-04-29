/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   get_next_line.h                                    :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: adbenoit <marvin@42.fr>                    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2019/11/14 14:17:42 by adbenoit          #+#    #+#             */
/*   Updated: 2019/11/27 18:37:26 by adbenoit         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#ifndef GET_NEXT_LINE_H
# define GET_NEXT_LINE_H

# include <stdlib.h>
# include <unistd.h>
# include <stdio.h>

typedef struct	s_list
{
	char			c;
	struct s_list	*next;
}				t_list;

typedef struct	s_tab
{
	int		fd;
	int		ret;
	size_t	size;
}				t_tab;

int				get_next_line(int fd, char **line);
int				ft_ret(char **line, t_tab *tab, t_list **lst, char *buf);
int				ft_linesize(char *buf, size_t *size, t_list **lst);
t_list			*ft_lstnew(char content);
t_list			*ft_lstlast(t_list *lst);
void			ft_lstadd_back(t_list **alst, t_list *new);
void			ft_lstclear(t_list **lst);
void			ft_line(t_list **lst, char **line);
void			ft_strcpy(char *buf);

#endif
