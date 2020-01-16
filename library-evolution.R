install.packages("devtools")
devtools::install_github("anonymous-marmot/marmotR")

library(dplyr)
library(tidyr)
library(ggplot2)
library(reshape2)

groupId <- "org.apache.felix"
artifactId <- "org.apache.felix.framework"
artifactQuery <- paste("[maven.groupId]=\"", groupId, "\" && [maven.artifactId]=\"", artifactId, "\" #[*]", sep="")

artifactData <- marmotR::search(query = artifactQuery, limit = 300)
artifactDF <- jsonlite::flatten(as.data.frame(artifactData$hits))

plotdata <- artifactDF %>% separate(metadata.version, remove = FALSE,  into = c("metadata.version.major", "metadata.version.minor", "metadata.version.patch"))
plotdata <- plotdata %>% arrange(metadata.version.major, metadata.version.minor, metadata.version.patch)


selectedData <- plotdata %>% select(metadata.version, metricResults.metrics.classversion.6, metricResults.metrics.classversion.5, metricResults.metrics.classversion.1.1)
selectedData <- selectedData %>% rename(`1.1` = metricResults.metrics.classversion.1.1, 
                                        `5` = metricResults.metrics.classversion.5,
                                        `6` = metricResults.metrics.classversion.6)
reshaped <- melt(selectedData, id.vars="metadata.version")  %>% separate(metadata.version, remove = FALSE,  into = c("metadata.version.major", "metadata.version.minor", "metadata.version.patch"))

classVersionByVersion <- ggplot(reshaped, aes(x = metadata.version, y = value, fill=variable)) +
  geom_col(na.rm = TRUE) + 
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  labs(x = "Project version", 
       y = "Number of classes",
       fill = "Class file version") 

ggsave(classVersionByVersion, filename = "felixClassVersion.pdf")


