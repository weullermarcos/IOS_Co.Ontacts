//
//  Contato+CoreDataProperties.h
//  CoOntacts
//
//  Created by Weuller Marcos on 15/11/16.
//  Copyright © 2016 Weuller. All rights reserved.
//

#import "Contato+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Contato (CoreDataProperties)

+ (NSFetchRequest<Contato *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *descricao;
@property (nullable, nonatomic, copy) NSString *email;
@property (nullable, nonatomic, copy) NSString *nome;
@property (nullable, nonatomic, copy) NSString *telefone;
@property (nullable, nonatomic, retain) NSData *imagem;

@end

NS_ASSUME_NONNULL_END
