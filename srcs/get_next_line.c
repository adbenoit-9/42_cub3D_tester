/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   get_next_line.c                                    :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: adbenoit <adbenoit@student.42.fr>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2019/11/12 15:44:13 by adbenoit          #+#    #+#             */
/*   Updated: 2020/01/29 13:46:03 by adbenoit         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "get_next_line.h"

int		ft_linesize(char *buf, size_t *size, t_list **lst)
{
	size_t	i;
	t_list	*new;

	i = -1;
	while (buf[++i] && buf[i] != '\n')
	{
		if ((*lst)->c == 0)
		{
			(*lst)->c = buf[i];
			(*lst)->next = NULL;
		}
		else
		{
			if (!(new = ft_lstnew(buf[i])))
				return (0);
			ft_lstadd_back(lst, new);
		}
		(*size)++;
	}
	if (buf[i] == '\n')
		return (1);
	return (-1);
}

void	ft_line(t_list **lst, char **line)
{
	size_t	i;
	t_list	*tmp;

	i = 0;
	tmp = *lst;
	if (*lst && (*lst)->c != 0)
	{
		while ((*lst)->next)
		{
			(*line)[i] = (*lst)->c;
			*lst = (*lst)->next;
			i++;
		}
		(*line)[i] = (*lst)->c;
		i++;
	}
	(*line)[i] = 0;
	ft_lstclear(&tmp);
}

int		ft_ret(char **line, t_tab *tab, t_list **lst, char *buf)
{
	long int		ret;
	int				k;

	while ((ret = read(tab->fd, buf, BUFFER_SIZE)) == BUFFER_SIZE)
	{
		if ((k = ft_linesize(buf, &tab->size, lst)) == 0)
			return (-1);
		if (k == 1 || ret <= 0)
			break ;
	}
	buf[ret] = 0;
	if (ret == -1)
		return (-1);
	if (ret < BUFFER_SIZE && ft_linesize(buf, &tab->size, lst) == -1)
	{
		if (!((*line) = malloc(sizeof(char) * (tab->size + 1))))
			return (-1);
		ft_line(lst, line);
		buf[0] = 0;
		return (0);
	}
	return (1);
}

int		ft_err(t_list **lst)
{
	ft_lstclear(lst);
	return (-1);
}

int		get_next_line(int fd, char **line)
{
	t_tab			tab;
	static char		buf[BUFFER_SIZE + 1];
	t_list			*lst;

	tab.size = 0;
	tab.fd = fd;
	if (!(lst = ft_lstnew('\0')) || fd < 0 || !line)
		return (ft_err(&lst));
	if (ft_linesize(buf, &tab.size, &lst) == 1 && buf[0] != 0)
		ft_strcpy(buf);
	else
	{
		if (BUFFER_SIZE == 0 || (tab.ret = ft_ret(line, &tab, &lst, buf)) == -1)
			return (ft_err(&lst));
		if (tab.ret == 0)
			return (0);
		ft_strcpy(buf);
	}
	if (!((*line) = malloc(sizeof(char) * (tab.size + 1))))
		return (ft_err(&lst));
	ft_line(&lst, line);
	return (1);
}
