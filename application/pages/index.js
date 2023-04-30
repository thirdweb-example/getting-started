import {
  useContract,
  useNFTs,
  ThirdwebNftMedia,
  Web3Button,
} from "@thirdweb-dev/react";
import { contractAddress } from "../const/yourDetails";

export default function Home() {
  const { contract } = useContract(contractAddress);
  const { data: nfts, isLoading: isReadingNfts } = useNFTs(contract);

  return (
    <div>
      <h2>My NFTs</h2>
      {isReadingNfts ? (
        <p>Loading...</p>
      ) : (
        <div>
          {nfts.map((nft) => (
            <>
              <ThirdwebNftMedia
                key={nft.tokenId}
                metadata={nft.metadata}
                height={200}
              />
              <h3>{nft.metadata.name}</h3>
            </>
          ))}
        </div>
      )}

      <Web3Button
        contractAddress={contractAddress}
        action={(contract) =>
          contract.erc721.mint({
            name: "Hello world!",
          })
        }
      >
        Mint NFT
      </Web3Button>
    </div>
  );
}
