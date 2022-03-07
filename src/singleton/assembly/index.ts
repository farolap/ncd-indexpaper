import { PersistentMap } from "near-sdk-core";

// Create the indexing Persistent map variable. From this variable you can store and check if the paper was indexed.
export const papers = new PersistentMap<string, Paper>("v");

// Create the paper class where it defines the necessary input parameters for indexing a paper.
@nearBindgen
class Paper {
  public doi: string
  public title: string
  public year: string
  public author: string
  public journal: string
  public volume: string
  public issn: string
  public pages: string

  constructor(
    title: string,
    author: string,
    year: string,
    journal: string,
    volume: string,
    issn: string,
    pages: string,
    doi: string)
      {
      this.title = title;
      this.author = author;
      this.year = year;
      this.journal = journal;
      this.volume = volume;
      this.issn = issn;
      this.pages = pages;
      this.doi = doi;}
}


@nearBindgen
export class Contract {

    //This function locates if the paper was indexed by its Digital Object Identifier (doi)
    checkifindexed(doi: string): string {
        let index = 'Not indexed';
        if (papers.get(doi)!==null){
           index   = 'indexed';
        }
        return index
    }

    //This function is the one that index the paper.
    @mutateState()
    indexpaper(
        title: string,
        author: string,
        year: string,
        journal: string,
        volume: string,
        issn: string,
        pages: string,
        doi: string): string{
          let paper = new Paper(title,author,year,
                                journal,volume,issn,pages,doi);
          papers.set(doi, paper);
          return 'Indexed as: '+paper.doi
    }

    //This function deletes the indexing if one commited an error. 
    @mutateState()
    delindexed(doi: string): string{
        let index = checkifindexed(doi);
        if (index===null){
            return "Not indexed" 
        }
        papers.delete(doi);
        return "Deleted"
    }
}


