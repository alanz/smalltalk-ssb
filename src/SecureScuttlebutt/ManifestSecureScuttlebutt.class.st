"
Provide interaction with a locally running secure scuttlebutt session, by accessing it via the 'sbot' CLI.

$ sbot --help
Secure-scuttlebutt API server

Commands:
  get                  Get a message by its hash-id.
  createFeedStream     (feed) Fetch messages ordered by their claimed timestamps.
  createLogStream      (log) Fetch messages ordered by the time received.
  messagesByType       (logt) Retrieve messages with a given type, ordered by receive-time.
  createHistoryStream  (hist) Fetch messages from a specific user, ordered by sequence numbers.
  createUserStream     Fetch messages from a specific user, ordered by sequence numbers.
  createWriteStream    write a number of messages to the local store.
                       will error if messages are not valid, but will accept
                       messages that the sbot doesn't replicate.
  links                Get a stream of messages, feeds, or blobs that are linked to/from an id.
  add                  Add a well-formed message to the database.
  publish              Construct a message using sbot's current user, and add it to the DB.
  getAddress           Get the address of the server. Default scope is public.
  getLatest            Get the latest message in the database by the given feedid.
  latest               Get the seq numbers of the latest messages of all users in the database.
  latestSequence       Get the sequence and local timestamp of the last received message from
                       a given `feedId`.
  whoami               Get information about the current sbot user.
  progress             returns an object reflecting the progress state of various plugins.
                       the return value is a `{}`  with subobjects showing `{start,current,target}`
                       to represent progress. Currently implemented are
                          `migration` (legacy->flume) migration progress and
                          `indexes`  (index regeneration).
  status               returns an object reflecting the status of various ssb operations,
                       such as db read activity, connection statuses, etc, etc. The purpose is to provide
                       an overview of how ssb is working.
  version              return the current version number of the running server

  friends.all          Fetch the graph structure.
  friends.hops         List the degrees-of-connection of all known feeds from the given feed.
  friends.createFriendStream 
                       Live-stream the ids of feeds which meet the given hops query. If `meta`
                       option is set, then will return steam of `{id, hops}`
  friends.get          Get the edge between two different feeds.

  gossip.peers         Get the current peerlist.
  gossip.add           Add an address to the peer table.
  gossip.remove        Remove an address from the peer table.
  gossip.ping          used internally by the gossip plugin to measure latency and clock skew
  gossip.connect       Add an address to the peer table, and connect immediately.
  gossip.changes       Listen for gossip events.
  gossip.reconnect     Tell sbot to reinitiate gossip connections now.
  gossip.enable        Update the config to enable a gossip type.
  gossip.disable       Update the config to disable a gossip type.

  invite.create        Create a new invite code.
  invite.accept        Use an invite code.
  invite.use           Use an invite code created by this sbot instance (advanced function).

  plugins.install      Install a plugin to Scuttlebot.
  plugins.uninstall    Uninstall a plugin from Scuttlebot.
  plugins.enable       Update the config to enable a plugin.
  plugins.disable      Update the config to disable a plugin.

  replicate.changes    Listen to replicate events.
  replicate.upto       returns {} of feeds to replicate, with sequences
  replicate.request    request a given feed, either as request(id) to replicate that feed,
                       or request(id, false) to disable replication.


"
Class {
	#name : #ManifestSecureScuttlebutt,
	#superclass : #PackageManifest,
	#category : #'SecureScuttlebutt-Manifest'
}
