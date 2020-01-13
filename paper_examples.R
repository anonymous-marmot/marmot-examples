install.packages("devtools")
devtools::install_github("anonymous-marmot/marmotR")

# Listing 1: ActiveMQ projects with more than 10 monitorexit instructions and 2 unused private fields
listing_one <- marmotR::search("[source] = \"Maven\" && [maven.groupId] = \"org.apache.activemq\" && ([metrics.bytecode.monitorexit] > 10 || [metrics.unusedfield.private] > 2)")

# Listing 3a: Old JVM code
listing_three_a <- marmotR::search("[metrics.bytecode.jsr]>0 && [metrics.bytecode.jsr_w]>0 && [metrics.bytecode.ret]>0")

# Listing 3b: Newer JVM code
listing_three_b <- marmotR::search("[metrics.bytecode.jsr]=0 && [metrics.bytecode.jsr_w]=0 && [metrics.bytecode.ret]=0")

# Listing 4: Projects with Crypto API usage
listing_four <- marmotR::search("[metrics.api.crypto.SecureRandom] > 0 || [metrics.api.crypto.Signature] > 0 || [metrics.api.crypto.Mac] > 0 || [metrics.api.crypto.Certificates] > 0 || [metrics.api.crypto.KeyHandling] > 0 || [metrics.api.crypto.MessageDigest] > 0 || [metrics.api.crypto.KeyStore] > 0 || [metrics.api.crypto.Cipher.getInstance] > 0")

# Listing 5: All data for log4j:log4j
listing_five <- marmotR::search("[maven.groupId] = \"org.apache.activemq\" #[*]")