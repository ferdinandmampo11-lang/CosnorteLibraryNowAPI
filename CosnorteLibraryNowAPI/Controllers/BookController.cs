using CosnorteLibraryNowAPI.models;
using Microsoft.AspNetCore.Mvc;

namespace CosnorteLibraryNowAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class BookController : ControllerBase
    {
        private static List<Book> books = new List<Book>
        {
            new Book
            {
                Id = 1,
                Title = "Ruined King: A League of Legends Story",
                Author = "Airship Syndicate",
                Genre = "Role-playing gamen",
                Available = true,
                PublishedYear = 2021
            },
            new Book
            {
                Id = 2,
                Title = "CONVERGENCE: A League of Legends Stor",
                Author = "Double Stallion",
                Genre = "Historical fiction / Literary fiction",
                Available = true,
                PublishedYear = 2023
            },
        };

        [HttpGet]
        public IActionResult GetAll()
        {
            return Ok(new
            {
                status = "success",
                data = books,
                message = "Books retrieved"
            });
        }

        [HttpGet("{id}")]
        public IActionResult GetById(int id)
        {
            var book = books.FirstOrDefault(b => b.Id == id);

            if (book == null)
            {
                return NotFound(new
                {
                    status = "error",
                    data = (object?)null,
                    message = "Book not found"
                });
            }

            return Ok(new
            {
                status = "success",
                data = book,
                message = "Book retrieved"
            });
        }

        [HttpPost]
        public IActionResult Create([FromBody] Book newBook)
        {
            newBook.Id = books.Count + 1;
            books.Add(newBook);

            return CreatedAtAction(
                nameof(GetById),
                new { id = newBook.Id },
                new
                {
                    status = "success",
                    data = newBook,
                    message = "Book created"
                }
            );
        }

        [HttpPut("{id}")]
        public IActionResult Update(int id, [FromBody] Book updateBook)
        {
            var book = books.FirstOrDefault(b => b.Id == id);

            if (book == null)
            {
                return NotFound(new
                {
                    status = "error",
                    data = (object?)null,
                    message = "Book not found"
                });
            }

            book.Title = updateBook.Title;
            book.Author = updateBook.Author;
            book.Genre = updateBook.Genre;
            book.Available = updateBook.Available;
            book.PublishedYear = updateBook.PublishedYear;

            return Ok(new
            {
                status = "success",
                data = book,
                message = "Book updated"
            });
        }

        [HttpDelete("{id}")]
        public IActionResult Delete(int id)
        {
            var book = books.FirstOrDefault(b => b.Id == id);

            if (book == null)
            {
                return NotFound(new
                {
                    status = "error",
                    data = (object?)null,
                    message = "Book not found"
                });
            }

            books.Remove(book);

            return Ok(new
            {
                status = "success",
                data = (object?)null,
                message = "Book removed"
            });
        }
    }
}