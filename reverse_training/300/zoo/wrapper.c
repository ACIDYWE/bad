#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <err.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <poll.h>
#include <stdio.h>

int main(void) {
  alarm(20);

  char name[15];
  int randfd = open("/dev/urandom", O_RDONLY);
  if (randfd == -1) err(1, "open rand");
  if (read(randfd, name, sizeof(name)-1) != sizeof(name)-1) errx(1, "can't read rand");
  close(randfd);
  for (int i=0; i<sizeof(name)-1; i++) {
    name[i] = (name[i] & 0xf) + 0x61;
  }
  name[sizeof(name)-1] = 0;
  printf("hello %s!\n", name);
  printf("starting the license checker for you...\n");

  int pp[2];
  if (socketpair(AF_UNIX, SOCK_STREAM, 0, pp)) err(1, "pipe");
  pid_t child = fork();
  if (child == -1) err(1, "fork");
  if (child == 0) {
    close(pp[1]);
    dup2(pp[0], 0);
    dup2(pp[0], 1);
    execl("./zoo", "zoo", NULL);
    err(1, "execve");
  }
  close(pp[0]);

  name[14] = '\n';
  if (write(pp[1], name, 15) != 15) errx(1, "can't write name");

  while (1) {
    char c;
    struct pollfd fds[2] = {
      {.fd = pp[1], .events = POLLIN},
      {.fd = 0, .events = POLLIN}
    };
    if (poll(fds, 2, -1) < 1) errx(1, "poll");
    if (fds[0].revents & POLLIN) {
      if (read(pp[1], &c, 1) != 1) errx(1, "read from child");
      if (write(1, &c, 1) != 1) errx(1, "write to peer");
    }
    if (fds[1].revents & POLLIN) {
      if (read(0, &c, 1) != 1) errx(1, "read from peer");
      if (write(pp[1], &c, 1) != 1) errx(1, "write to child");
    }
  }
}
