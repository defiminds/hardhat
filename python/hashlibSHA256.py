import hashlib

# Block header information
version = 1
prev_block_hash = '0000000000000000000000000000000000000000000000000000000000000000'
merkle_root_hash = 'f34df1a9acaeed99decd873812f56aa2371a166a2852cb60db739eac9f85b99e'
timestamp = 1231006505
bits = 486604799
nonce = 2083236893

# Concatenate block header fields
block_header = str(version) + prev_block_hash + merkle_root_hash + str(timestamp) + str(bits) + str(nonce)

# Double hash block header
hash_result = hashlib.sha256(hashlib.sha256(block_header.encode('utf-8')).digest()).hexdigest()

# Display hash result
print("Block hash:", hash_result)
