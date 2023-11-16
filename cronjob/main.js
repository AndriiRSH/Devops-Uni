const redis = require("redis");
const chokidar = require("chokidar");
const fs = require("fs");

const redisClient = redis.createClient({
  host: "localhost",
  port: 6379,
});

const filePath = "/var/log/my-app.log";

const updateRedisInfo = () => {
  fs.stat(filePath, (err, stats) => {
    if (err) {
      console.error("Помилка при отриманні інформації про файл:", err);
      return;
    }

    const fileInfo = {
      size: stats.size,
      lastModified: stats.mtime.toISOString(),
    };

    redisClient.hmset("my-app-file-info", fileInfo, (redisErr) => {
      if (redisErr) {
        console.error("Помилка при записі в Redis:", redisErr);
      } else {
        console.log("Інформацію успішно записано в Redis.");
      }
    });
  });
};

const watcher = chokidar.watch(filePath);

watcher.on("change", () => {
  console.log("Файл був змінений. Оновлюємо інформацію в Redis...");
  updateRedisInfo();
});

console.log("Cron Job для відстеження файлу запущено.");
