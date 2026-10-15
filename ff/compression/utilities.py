import random
import string
import zlib

from ..constants import get_logger

logger = get_logger(__name__)

_RAVEN_COMMENT = """The Raven

Once upon a midnight dreary, while I pondered, weak and weary,
Over many a quaint and curious volume of forgotten lore—
While I nodded, nearly napping, suddenly there came a tapping,
As of some one gently rapping, rapping at my chamber door.
“’Tis some visiter,” I muttered, “tapping at my chamber door—
Only this and nothing more.”

Ah, distinctly I remember it was in the bleak December;
And each separate dying ember wrought its ghost upon the floor.
Eagerly I wished the morrow;—vainly I had sought to borrow
From my books surcease of sorrow—sorrow for the lost Lenore—
For the rare and radiant maiden whom the angels name Lenore—
Nameless here for evermore.

And the silken sad uncertain rustling of each purple curtain
Thrilled me—filled me with fantastic terrors never felt before;
So that now, to still the beating of my heart, I stood repeating
“’Tis some visiter entreating entrance at my chamber door—
Some late visiter entreating entrance at my chamber door;
This it is and nothing more.”

Presently my soul grew stronger; hesitating then no longer,
“Sir,” said I, “or Madam, truly your forgiveness I implore;
But the fact is I was napping, and so gently you came rapping,
And so faintly you came tapping, tapping at my chamber door,
That I scarce was sure I heard you”—here I opened wide the door—
Darkness there and nothing more.

Deep into that darkness peering, long I stood there wondering, fearing,
Doubting, dreaming dreams no mortals ever dared to dream before;
But the silence was unbroken, and the stillness gave no token,
And the only word there spoken was the whispered word, “Lenore!”
This I whispered, and an echo murmured back the word, “Lenore!”—
Merely this and nothing more.

Back into the chamber turning, all my soul within me burning,
Soon again I heard a tapping somewhat louder than before.
“Surely,” said I, “surely that is something at my window lattice;
Let me see, then, what thereat is and this mystery explore—
Let my heart be still a moment and this mystery explore;—
’Tis the wind and nothing more.”

Open here I flung the shutter, when, with many a flirt and flutter,
In there stepped a stately Raven of the saintly days of yore.
Not the least obeisance made he; not a minute stopped or stayed he,
But, with mien of lord or lady, perched above my chamber door—
Perched upon a bust of Pallas just above my chamber door—
Perched, and sat, and nothing more.

Then the ebony bird beguiling my sad fancy into smiling,
By the grave and stern decorum of the countenance it wore,
“Though thy crest be shorn and shaven, thou,” I said, “art sure no craven,
Ghastly grim and ancient Raven wandering from the Nightly shore—
Tell me what thy lordly name is on the Night’s Plutonian shore!”
Quoth the Raven, “Nevermore.”

Much I marvelled this ungainly fowl to hear discourse so plainly,
Though its answer little meaning—little relevancy bore;
For we cannot help agreeing that no living human being
Ever yet was blessed with seeing bird above his chamber door—
Bird or beast upon the sculptured bust above his chamber door,
With such name as “Nevermore.”

But the Raven, sitting lonely on that placid bust, spoke only
That one word, as if its soul in that one word he did outpour
Nothing farther then he uttered; not a feather then he fluttered—
Till I scarcely more than muttered: “Other friends have flown before—
On the morrow he will leave me, as my Hopes have flown before.”
Then the bird said “Nevermore.”

Startled at the stillness broken by reply so aptly spoken,
“Doubtless,” said I, “what it utters is its only stock and store,
Caught from some unhappy master whom unmerciful Disaster
Followed fast and followed faster till his songs one burden bore—
Till the dirges of his Hope that melancholy burden bore
Of ‘Never—nevermore.’”

But the Raven still beguiling all my sad soul into smiling,
Straight I wheeled a cushioned seat in front of bird and bust and door;
Then, upon the velvet sinking, I betook myself to linking
Fancy unto fancy, thinking what this ominous bird of yore—
What this grim, ungainly, ghastly, gaunt, and ominous bird of yore
Meant in croaking “Nevermore.”

This I sat engaged in guessing, but no syllable expressing
To the fowl whose fiery eyes now burned into my bosom’s core;
This and more I sat divining, with my head at ease reclining
On the cushion’s velvet lining that the lamp-light gloated o’er,
But whose velvet violet lining with the lamp-light gloating o’er
She shall press, ah, nevermore!

Then, methought, the air grew denser, perfumed from an unseen censer
Swung by Seraphim whose foot-falls tinkled on the tufted floor.
“Wretch,” I cried, “thy God hath lent thee—by these angels he hath sent thee
Respite—respite and nepenthe from thy memories of Lenore!
Quaff, oh quaff this kind nepenthe and forget this lost Lenore!”
Quoth the Raven, “Nevermore.”

“Prophet!” said I, “thing of evil!—prophet still, if bird or devil!—
Whether Tempter sent, or whether tempest tossed thee here ashore,
Desolate, yet all undaunted, on this desert land enchanted—
On this home by Horror haunted—tell me truly, I implore—
Is there—is there balm in Gilead?—tell me—tell me, I implore!”
Quoth the Raven, “Nevermore.”

“Prophet!” said I, “thing of evil!—prophet still, if bird or devil!
By that Heaven that bends above us—by that God we both adore—
Tell this soul with sorrow laden if, within the distant Aidenn,
It shall clasp a sainted maiden whom the angels name Lenore—
Clasp a rare and radiant maiden whom the angels name Lenore.”
Quoth the Raven, “Nevermore.”

“Be that our sign of parting, bird or fiend!” I shrieked, upstarting—
“Get thee back into the tempest and the Night’s Plutonian shore!
Leave no black plume as a token of that lie thy soul has spoken!
Leave my loneliness unbroken!—quit the bust above my door!
Take thy beak from out my heart, and take thy form from off my door!”
Quoth the Raven, “Nevermore.”

And the Raven, never flitting, still is sitting, still is sitting
On the pallid bust of Pallas just above my chamber door;
And his eyes have all the seeming of a demon’s that is dreaming
And the lamp-light o’er him streaming throws his shadows on the floor;
And my soul from out that shadow that lies floating on the floor
Shall be lifted—nevermore!"""


def end_pos(data: bytes, start: int) -> int:
    return data.find(b"\xff\xff\xff\xff", start)


def get_dword(data: bytes, offset: int) -> int:
    return int.from_bytes(data[offset : offset + 4], byteorder="little", signed=False)


def set_dword(data: bytes, dword: int, offset: int, *, reverse=False) -> bytes:
    _bytes = dword.to_bytes(4, byteorder="little")

    if reverse:
        _bytes = _bytes[::-1]

    return data[0:offset] + _bytes + data[offset + 4 :]


def _padding_comment_prefix(data: bytes) -> bytes | None:
    """Return the invariant prefix before an appended trailing block comment."""
    try:
        text = data.decode("utf-8")
    except UnicodeDecodeError:
        return None

    comment_start = text.rfind("/*")
    if comment_start >= 0:
        comment_end = text.find("*/", comment_start + 2)
        if comment_end >= 0 and text[comment_end + 2 :].strip() == "":
            text = text[:comment_start].rstrip()

    return text.encode("utf-8") + b"\n/*\n"


def _compress_with_comment_padding(data: bytes, original: bytes) -> bytes | None:
    """Find a Raven prefix plus deterministic padding that matches the original slot."""
    target = len(original)
    raven = _RAVEN_COMMENT.encode("utf-8")
    generator = random.Random(0)
    random_padding = "".join(generator.choices(string.ascii_letters + string.digits, k=target * 2)).encode("ascii")

    prefix = _padding_comment_prefix(data)
    if prefix is None:
        return None

    base_compressor = zlib.compressobj(level=9)
    compressed_prefix = base_compressor.compress(prefix)

    def compress_comment(comment: bytes) -> bytes:
        compressor = base_compressor.copy()
        return compressor.compress(comment) + compressor.compress(b"\n*/") + compressor.flush()

    best_comment = None
    for raven_length in range(len(raven) + 1):
        comment = raven[:raven_length]
        compressed_suffix = compress_comment(comment)
        compressed_length = len(compressed_prefix) + len(compressed_suffix)
        if compressed_length == target:
            return compressed_prefix + compressed_suffix
        if compressed_length > target:
            break
        best_comment = comment

    if best_comment is None:
        return None

    def compressed_suffix_with_padding(padding_length: int) -> bytes:
        comment = best_comment + random_padding[:padding_length]
        return compress_comment(comment)

    low = 0
    high = len(random_padding)
    while low <= high:
        padding_length = (low + high) // 2
        compressed_suffix = compressed_suffix_with_padding(padding_length)
        compressed_length = len(compressed_prefix) + len(compressed_suffix)
        if compressed_length == target:
            return compressed_prefix + compressed_suffix
        if compressed_length < target:
            low = padding_length + 1
        else:
            high = padding_length - 1

    for padding_length in range(max(0, high - 256), min(len(random_padding), low + 256) + 1):
        compressed_suffix = compressed_suffix_with_padding(padding_length)
        if len(compressed_prefix) + len(compressed_suffix) == target:
            return compressed_prefix + compressed_suffix

    return None


def compress(data: bytes, original: bytes, name: str, *, check: bool = True) -> bytes:
    compressed = zlib.compress(data, level=9)
    if check:
        padded = _compress_with_comment_padding(data, original)
        if padded is not None:
            return padded

        if len(compressed) == len(original):
            return compressed

        raise ValueError(
            f"New data for {name} is not the same size as the old data - Original size: {len(original)}, New size: {len(compressed)}"
        )
    elif len(compressed) != len(original):
        compressed += b"\x00" * (len(original) - len(compressed))
    return compressed
