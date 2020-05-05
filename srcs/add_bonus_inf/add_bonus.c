#include "../get_next_line.h"

int ft_add_bonus(char *file, char *bonus, char *new)
{
    char buffer[4096];
    char ret[4096];
    char *line;
    int fd;
    size_t size;
    int i;
    int j;
    int k;
    size_t x;
    int y;

    fd = open(bonus, O_RDONLY);
    size = read(fd, buffer, 4096);
    buffer[size] = 0;
    close(fd);
    fd = open(file, O_RDONLY);
    k = 0;
    x = 0;
    while ((j = get_next_line(fd, &line)) == 1 && k < 4096)
    {
        i = 0;
        y = 0;
        while (line[y] == ' ')
            y++;
        while (line[i])
        {
            if (line[y] == '1')
            {
                while (x < size && k < 4096)
                {
                    ret[k] = buffer[x];
                    k++;
                    x++;
                    if (x == size)
                    {
                        ret[k] = '\n';
                        k++;
                    }
                }
            }
            ret[k] = line[i];
            i++;
            k++;
        }
        ret[k] = '\n';
        k++;
    }
    i = 0;
    while (line[i])
    {
        ret[k] = line[i];
        i++;
        k++;
    }
    ret[k] = 0;
    close(fd);
    fd = open(new, O_CREAT | O_WRONLY | O_TRUNC, 0755);
    write(fd, &ret, k);
    close(fd);
    if (j == -1)
        return (0);
    return (1);
}

int main(int ac, char **av)
{
    if (ac != 4)
        return (0);
    if (ft_add_bonus(av[1], av[2], av[3]) == 0)
        return (0);
    return (1);
}